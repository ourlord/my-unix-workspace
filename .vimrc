" Default setups for Vundle
set nocompatible
filetype off                  " required
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
if has('nvim')
  let g:python3_host_prog='/usr/bin/python3'
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" == plugin on GitHub repo ==
Plugin 'tpope/vim-fugitive'
" == New auto complete plugin from Shougo ==
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
else
  " == AutoComplPop ==
  Plugin 'vim-scripts/AutoComplPop'
  " == OmniCppComplete ==
  Plugin 'vim-scripts/OmniCppComplete'
endif
" == New snippets plugin from Shougo ==
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
" Plugin key-mappings
" Note: It must be "imap" and "smap". It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap". It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumbisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" == bufexplorer ==
Plugin 'fholgado/minibufexpl.vim'
" nature mapping
nmap <F6> :bp<CR>
nmap <F7> :bn<CR>
" == Tree style file explorer ==
Plugin 'scrooloose/nerdtree'
" open NERDTree when vim start up empty
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabFree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
" == rainbow parentheses ==
Plugin 'oblitum/rainbow'
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
" close preview window after completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" == cpp-enhanced-highlight ==
Plugin 'ourlord/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight=1           " highlight class scope
let g:cpp_member_variable_highlight=1       " highlight member variables
let g:cpp_experimental_template_highlight=0 " highlighting of template functions(experimental)
" == ctags.vim ==
Plugin 'vim-scripts/ctags.vim'
:set tags=./tags;/,tags;/home/
" == grep.vim ==
Plugin 'vim-scripts/grep.vim'
" set up a very useful shortcuts for Grep.Vim
set grepprg=grep\ -nrI\ --exclude="*tags"\ --exclude="*.cscope"\ --exclude=".*.swp"\ --exclude="\.*"\ $*\ /dev/null
nnoremap <silent> <F3> :Rgrep <CR>
" == delimitMate ==
" auto closing parameters quotes etc.
Plugin 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
" == ctrlp.vim ==
" Fuzzy search for filename, buffers etc..
Plugin 'kien/ctrlp.vim'
" == cscope.vim ==
Plugin 'ourlord/vim-cscope'
if has('cscope')
""  set cscopetag cscopeverbose

" disable these since conflict with g] (ctags)
  "if has('quickfix')
  "  set cscopequickfix=s-,c-,d-,i-,t-,e-
  "endif

  "cnoreabbrev csa cs add
  cnoreabbrev csf cs find 
  cnoreabbrev csff cs find f 
  cnoreabbrev csfs cs find s 
  cnoreabbrev csfc cs find c 
  cnoreabbrev csfg cs find g 
  "cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset 
  cnoreabbrev css cs show 
  cnoreabbrev csh cs help 
endif
" == vim-signify ==
" Show diff for the file current editting
Plugin 'mhinz/vim-signify'
" == vim-codefmt ==
" Add maktaba and codefmt to the runtimepath
" (The latter mustst be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage
Plugin 'google/vim-glaive'
" == vim-commentary ==
" to auto comment a line of code or a block of code
Plugin 'tpope/vim-commentary'
" == vim-helm ==
" syntax for helm templates (yaml + gotmpl + sprig + custom)
Plugin 'towolf/vim-helm'
" == vim-go ==
" Golang support for vim
Plugin 'fatih/vim-go'
let g:go_def_mode='godef'
if has('nvim')
  Plugin 'stamblerre/gocode', {'rtp': 'nvim/'}
else
  Plugin 'stamblerre/gocode', {'rtp': 'vim/'}
endif
" == fancy status bar ==
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='fruit_punch'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" the galive#Install() should go after the "call vundle#end()"
"call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
" Glaive codefmt plugin[mappings]
" Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Set color scheme!
set t_Co=256
"colorscheme base16-tomorrow
colorscheme Tomorrow-Night
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
if !has('nvim')
  set esckeys
endif
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
set redrawtime=10000 " workaround for highlight breaks in 8.0
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
"set tabstop=4 " The width of a hard tabstop measured in 'spaces'
"set shiftwidth=4 " Size of indent. number of tabs times tabstop
"set softtabstop=4 " non zero making spaces as tab
"set expandtab " insert spaces instead of tab character
set smarttab " depends on the near indentation to choose tab or space
set smartindent
set backspace=2
set cindent
" Enable line numbers
set number
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Respect modeline in files
set modeline
set modelines=4
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
"set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Automatic commands
if has("autocmd")
        " Enable file type detection
        filetype on
        " Treat .json files as .js
        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif
" set lines and columns
" set lines=50 columns=100
" use tree view in file explorer
let g:netrw_liststyle=3
" hide the file explorer banner
let g:netrw_banner=0
" hide the menu bar and toolbar
:set guioptions-=m "remove menu bar
:set guioptions-=T "remove toolbar
:set guioptions-=r "remove right-hand scroll bar
:set guioptions-=L "remove left-hand scroll bar
" change cursor shape between insert and normal mode in iTerm2.app
let &t_SI="\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI="\<Esc>]50;CursorShape=0\x7" " Block in normal mode
