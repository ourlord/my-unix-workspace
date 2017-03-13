# my-unix-workspace
Procedures to build my Unix workspace. Including my main editor vim with a python support. Also some files like my `.bashrc` my iTerm2 profile.

## First Thing First - VIM
 
Install `Vundle` from [here](https://github.com/VundleVim/Vundle.vim) which requires `git`. If you workspace (i.e. build machines) doesn't allow you to have a natural `git`, the simplest way is to create a VM and intall git and run `:PluginInstall` from there then `scp` the whole `.vim` repo to your workspace.

## Plugins in My Vim

Most of plugins in my vimrc require nothing but a vim7.3+. Some of them needs additional supports. `Ultisnips` requires python2.7+. So I normally use alternative `vim-snipmate`. `YouCompleteMe` is an excellent autocomplete plugin for multi-language support, which requires some special libs/deps that would not be normally installed in your workspace (i.e. build machine).

Typically if `YouCompleteMe` is not included, a vim7.3+ is good enough to use all other feature in my vimrc. However here talks about how to build vim workspace with `YouCompleteMe` supports.

I have a local clone of some plugin repo because I modified them. And I know two of them are still active for now. Just in case I grow old and starts to forget things. Here is the procedure to keep these local repo align with the upstream repo.

```
git clone <my plugin repo>
git remote add upstream <original plugin repo>
git pull upstream master
<fix the merge - the fun part LOL>
git commit -am <blablabla>
git push origin
```
Open vim and do a `:PluginUpdate` to get the changes.

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

[Here](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source) is a good reference for compiling Vim from source, from `YouCompleteMe` wiki.
 
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

Well, I did not make this session works properly for now. So just for reference. No gurantee.
The detail steps is under `YouCompleteMe` [github page](https://github.com/Valloric/YouCompleteMe).

Basically the steps are:

```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```

Seems the install scipt will download the correct clang so we shouldn't need to worry about that.

Ok, here comes the fun part: the gcc on my workspace (i.e. build machine) is too old that ran into a compilation issue when run `./install.py` to install `YouCompleteMe`. And I have to compile gcc from source. I found a very [useful guide](http://stackoverflow.com/questions/9450394/how-to-install-gcc-piece-by-piece-with-gmp-mpfr-mpc-elf-without-shared-libra) could save thousands of time figuring out things by oneself.

**Change the `wget` link from that page to use the other version of source package and use `--enable-shared` flag to configure all the builds because `YouCompleteMe` needs those shared library. Also, add `LD_RUN_PATH` with the lib path(`$HOME/Applications` in my case).**

Configure and build gcc:

```
cd gcc-4.8.5
./configure --prefix=$HOME/Applications \
            --enable-shared \
            --disable-bootstrap \
            --disable-libstdcxx-pch \
            --enable-languages=c,c++ \
            --enable-libgomp \
            --enable-lto \
            --enable-threads=posix \
            --with-gmp=$HOME/Applications \
            --with-mpfr=$HOME/Applications \
            --with-mpc=$HOME/Applications \
            --with-libelf=$HOME/Applications \
            --with-fpmath=sse \
            --disable-multilib
make && make install
```

When run `./install.py --clang-completer', remember to set up the environment variables to allow `cmake` using the correct `gcc` by

```
export CC=$HOME/Applications/bin/gcc
export CXX=$HOME/Applications/bin/g++
```

