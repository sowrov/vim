" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" File tree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Fonts?
Plugin 'ryanoasis/vim-devicons'
Plugin 'powerline/fonts'

" Airline
Plugin 'bling/vim-airline'

" Editor Config
"Plugin 'editorconfig/editorconfig-vim'

"Auto-completion for quotes, parens, brackets, etc
Plugin 'Raimondi/delimitMate'

"Auto-complete if with endif or c++ preprocessors...
Plugin 'tpope/vim-endwise'

"Syntax check for may languages
Plugin 'scrooloose/syntastic'

"Auto-complete on tab
Plugin 'ervandew/supertab'

"Split single line statement to multiline or vice versa
Plugin 'AndrewRadev/splitjoin.vim'

" Pasting in Vim with indentation adjusted to destination context.
Plugin 'sickill/vim-pasta'

" Color Schemes
Plugin 'flazz/vim-colorschemes'

"Language specifice plugins
"Plugin 'klen/python-mode', {'for': 'python'}
Plugin 'vim-scripts/python.vim', {'for': 'python'}
Plugin 'vim-scripts/python_match.vim', {'for': 'python'}
Plugin 'vim-scripts/pythoncomplete', {'for': 'python'}
Plugin 'gregsexton/MatchTag', { 'for': 'html' }
Plugin 'pangloss/vim-javascript', { 'for': 'javascript' }
Plugin 'moll/vim-node', { 'for': 'javascript' }
Plugin 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plugin 'elzr/vim-json', { 'for': 'json' }
Plugin 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plugin 'groenewege/vim-less', { 'for': 'less' }
Plugin 'ap/vim-css-color', { 'for': 'css' }
Plugin 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plugin 'fatih/vim-go', { 'for': 'go' }
Plugin 'vim-airline/vim-airline-themes'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" ---------configurations--------------
set nocompatible
filetype off                  " required
syntax on
colorscheme corporation

scriptencoding utf-8 " utf-8 all the way
set encoding=utf-8

set autoread " detect when a file is changed
set history=200 " change history to 200
set textwidth=120

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Tab control
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest
" Spaces instead of tabs
set expandtab
" Always  set auto indenting on
set autoindent

set clipboard=unnamed "Put yank to clipboard

" code folding settings
set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

" Gui fonts
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h9

" StatusLine
set laststatus=2 " show the satus line all the time

" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','

"python
"let g:pymode_python = 'python3'

" airline options
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='cool'

" ----- end airline -----

"Restore screen size and position
if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\.vim\_vimsize'
    else
      return $HOME.'/.vim/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif
"----------Endof Restore screen code----------
" ---------old-------------------
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

