" Default setups for Vundle
set nocompatible
filetype off                  " required
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" == plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" == snippets plugin not required python
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" == snippets database
Plugin 'ourlord/vim-snippets'
" == bufexplorer ==
Plugin 'jlanzarotta/bufexplorer'
Plugin 'fholgado/minibufexpl.vim'
" nature mapping
nmap <F6> :bp<CR>
nmap <F7> :bn<CR>
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
" == AutoComplPop ==
Plugin 'vim-scripts/AutoComplPop'
" == OmniCppComplete ==
Plugin 'vim-scripts/OmniCppComplete'
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
" == yang.vimrc ==
" YANG language syntax in VIM
Plugin 'ourlord/yang.vim'
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
Plugin 'mhinz/vim-signify'
" == YouCompleteMe ==
"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_auto_start_csharp_server = 0
"let g:ycm_key_list_select_completion = ['<Enter>', '<Down>']
" == vim-codefmt ==
" Add maktaba and codefmt to the runtimepath
" (The latter mustst be installed before it can be used.)
"Plugin 'google/vim-maktaba'
"Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage
"Plugin 'google/vim-glaive'
" == vim-commentary ==
" to auto comment a line of code or a block of code
Plugin 'tpope/vim-commentary'
" == vim-helm ==
" syntax for helm templates (yaml + gotmpl + sprig + custom)
Plugin 'towolf/vim-helm'
" == vim-go ==
" Golang support for vim
Plugin 'fatih/vim-go'

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
set esckeys
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
set shortmess=atI
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

