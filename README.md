# my-vim-workspace
Procedures to build my vim workspace

## First Thing First
 
Install `Vundle` from [here](https://github.com/VundleVim/Vundle.vim) which requires `git`. If you workspace (i.e. build machines) doesn't allow you to have a natural `git`, the simplest way is to create a VM and intall git and run `:PluginInstall` from there then `scp` the whole `.vim` repo to your workspace.

## Plugins in My Vim

Most of plugins in my vimrc require nothing but a vim7.3+. Some of them needs additional supports. `Ultisnips` requires python2.7+. So I normally use alternative `vim-snipmate`. `YouCompleteMe` is an excellent autocomplete plugin for multi-language support, which requires some special libs/deps that would not be normally installed in your workspace (i.e. build machine).

Typically if `YouCompleteMe` is not included, a vim7.3+ is good enough to use all other feature in my vimrc. However here talks about how to build vim workspace with `YouCompleteMe` supports.

## Build Python2.7+ From Source

Find Python2.7 tarball from [offical website](https://www.python.org/downloads/release/python-2712/). I typically don't `ensurepip` because that requires OpenSSL libs.

```
cd ~/workspace
wget <python tarball link>
tar -zxf Python-2.7.12.tar.gz
cd Python-2.7.12
./configure --prefix=$HOME/Applications \
            --enable-shared \
            --with-system-expat \
            --with-system-ffi \
            --without-ensurepip
make && make install
```

## Build Vim From Source

```
mkdir ~/workspace/vim_src
cd ~/workspace/vim_src
git clone https://github.com/vim/vim.git
cd vim
./configure --prefix=$HOME/Applications \
            --enable-features=huge \
            --enable-fail-if-missing \
            --with-local-dir=$HOME/Applications \
            --enable-pythoninterp \
            --with-python-config-dir=$HOME/Applications/lib/python2.7/config \
            --enable-multibyte
make VIMRUNTIMEDIR=$HOME/Applications/share/vim/vim74
make install
```

Well done. A Vim7.3+ with Python2.7+ support is ready to use. Use `vim --version | tr '-' '\n' | grep python` to check if current vim is the correct one with python supports.

(Here)[https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source] is a good reference for compiling Vim from source, from `YouCompleteMe` wiki.
 
### Build cmake From Source

cmake is only required by `YouCompleteMe`. Official [help page](https://cmake.org/install/). Download link can find there.

```
cd ~/workspace
wget <cmake tarball>
tar -zxf cmake-3.6.0-rc4.tar.gz
cd cmake-3.6.0-rc4
./bootstrap --prefix=$HOME/Applications --system-expat --no-qt-gui --parallel=8
make && make install
```

### Install `YouCompleteMe`

The detail steps is under `YouCompleteMe` [github page](https://github.com/Valloric/YouCompleteMe).

Basically the steps are:

```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

Seems the install scipt will download the correct clang so we shouldn't need to worry about that.