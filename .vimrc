"******* BEGIN PLUGIN INCLUSION *******"
" Vundle setup
filetype off
set rtp+=/Users/.vim/Vundle.vim/
call vundle#rc()

" Vundle bundle definitions - github repos
Bundle 'VundleVim/Vundle.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'clvv/a.vim'
Bundle 'othree/coffee-check.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-abolish'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-fugitive'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-entire'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-capslock'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdcommenter'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-eunuch'

" Vundle bundle definitions - vim-scripts repos
Bundle 'matchit.zip'

" Vundle bundle definitions - non-github repos
"Bundle 'git://git.example.com/example.git'

" Enable filetype plugins
filetype plugin on
"******** END PLUGIN INCLUSION ********"

" Configure indenting
filetype indent on  " Required for Vundle (in addition to just being a good setting)
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Configure history
set history=200

" Configure scrolling
set scrolloff=3

" Configure folding
set foldlevelstart=99 " Expand all folds by default
set foldmethod=syntax

" Enable the mouse
set mouse=a

" Link the system clipboard to the unnamed register
set clipboard=unnamed

" Activate solarized color scheme
syntax enable
set background=dark
colorscheme solarized

" Configure line numbering
set number
"set nonumber
"set norelativenumber
"set relativenumber
":au FocusLost * :set number
":au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

function! NumberingMethodToggle()   " Adapted from numbers.vim
  if (&number)
    set relativenumber
  else
    set number
  endif
endfunc

nnoremap <silent> <Leader>n :call NumberingMethodToggle()<CR>
vnoremap <silent> <Leader>n :<C-u>call NumberingMethodToggle()<CR>gv

nnoremap <silent> <Leader>N :set nonumber \| set norelativenumber<CR>
vnoremap <silent> <Leader>N :<C-u>set nonumber \| set norelativenumber<CR>gv

" Configure maximum line length highlighting
if exists("&colorcolumn")
  set colorcolumn=80
  highlight ColorColumn ctermfg=Red
endif

"******* BEGIN LINE WRAPPING CONFIGURATION *******"
" Don't break in the middle of words
set linebreak

" Remap keys to operate on display lines
nnoremap <silent> k      gk
vnoremap <silent> k      gk
onoremap <silent> k      gk
nnoremap <silent> <Up>   g<Up>
vnoremap <silent> <Up>   g<Up>
onoremap <silent> <Up>   g<Up>
inoremap <silent> <expr> <Up> ImapPreserveOmnicomplete("<Up>", "<C-o>gk")
nnoremap <silent> j      gj
vnoremap <silent> j      gj
onoremap <silent> j      gj
nnoremap <silent> <Down> g<Down>
vnoremap <silent> <Down> g<Down>
onoremap <silent> <Down> g<Down>
inoremap <silent> <expr> <Down> ImapPreserveOmnicomplete("<Down>", "<C-o>gj")
nnoremap <silent> ^      g^
vnoremap <silent> ^      g^
onoremap <silent> ^      g^
nnoremap <silent> <Home> g^
vnoremap <silent> <Home> g^
onoremap <silent> <Home> g^
inoremap <silent> <Home> <C-o>g^
nnoremap <silent> $      g$
vnoremap <silent> $      g$
onoremap <silent> $      g$
nnoremap <silent> <End>  g<End>
vnoremap <silent> <End>  g<End>
onoremap <silent> <End>  g<End>
inoremap <silent> <End>  <C-o>g<End>

" Maintain original functionality for Omnicomplete
function! ImapPreserveOmnicomplete(key, mapping)
  return pumvisible() ? a:key : a:mapping
endfunction
"******** END LINE WRAPPING CONFIGURATION ********"

" Configure number incrementation
set nrformats=hex

" Enable and configure the wildmenu
set wildmenu
set wildmode=list:longest,full

" Configure search
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <Leader>h :nohlsearch<CR>
vnoremap <Leader>h :<C-u>nohlsearch<CR>gv

" Configure encryption
if exists("&blowfish")
  set cryptmethod=blowfish2
endif

" Configure the backspace key
set backspace=indent,eol,start

" Create hotkeys for deleting trailing whitespace
nnoremap <Leader>dtw :%s/\v\s+$//<CR><C-o>
vnoremap <Leader>dtw :s/\v\s+$//<CR>gv

"******* BEGIN STATUSLINE CONFIGURATION *******"
" Add the current git branch to the default statusline
set statusline=%<                             " Left-align the initial first part of the statusline
set statusline+=%n:\ %f                       " Buffer #: Filename
set statusline+=\ (%{fugitive#head()})        " (git branch)
set statusline+=\ %h%m%r                      " [Help][Modified?(+|-)][ReadOnly?(RO)]
set statusline+=%=                            " Right-align the remaining part of the statusline
set statusline+=%l/%L\ %P                     " Lines in / Total Lines XX%

" Always display the statusline
set laststatus=2
"******** END STATUSLINE CONFIGURATION ********"

" Configure . to execute across a visual selection
vnoremap . :normal .<CR>

"******* BEGIN PLUGIN CONFIGURATION *******"
" Configure Omnicomplete
let g:ftplugin_sql_omni_key = '<C-f>'

" Configure NerdTree
nnoremap <silent> <Leader>o :NERDTreeToggle<CR>
vnoremap <silent> <Leader>o :<C-u>NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1  " Close the NERDTree after a file has been opened
let NERDTreeChDirMode = 2   " Keep the CWD and NERDTree's root in sync
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is NerdTree

" Configure CtrlP
let g:ctrlp_map = '<Leader>f'

" Configure Gundo
nnoremap <silent> <Leader>u :GundoToggle<CR>
vnoremap <silent> <Leader>u :<C-u>GundoToggle<CR>
let g:gundo_close_on_revert = 1 " Close the gundo windo after reverting

" Configure Fugitive
nnoremap <silent> <Leader>gs :Gstatus<CR>
vnoremap <silent> <Leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
vnoremap <silent> <Leader>gd :<C-u>Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
vnoremap <silent> <Leader>gb :<C-u>Gblame<CR>
nnoremap <silent> <Leader>gw :Gwrite<CR>
vnoremap <silent> <Leader>gw :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>ga :Gwrite<CR>
vnoremap <silent> <Leader>ga :<C-u>Gwrite<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
vnoremap <silent> <Leader>gc :<C-u>Gcommit<CR>
nnoremap <silent> <Leader>gp :Git push<CR>
vnoremap <silent> <Leader>gp :<C-u>Git push<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete " Delete fugitive buffers when they're hidden

" Configure Tabular
" TODO: Visual mode mappings (e.g. \t=)
" TODO: Normal mode mappings that accept a movement (e.g. \t=5j)
"******** END PLUGIN CONFIGURATION ********"

"******* BEGIN FILETYPE CONFIGURATION *******"
"TODO: Make only work for .less files
nnoremap <Leader>c :w <BAR> !lessc % > %:t:r.css<CR>
vnoremap <Leader>c :<C-u>w <BAR> !lessc % > %:t:r.css<CR>gv
"******** END FILETYPE CONFIGURATION ********"

" Fix typos
abbreviate W w
abbreviate Q q

" Save a read-only file that wasn't opened with sudo
cnoremap w!! w !sudo tee % >/dev/null

" Configure vim-slime
let g:slime_target = "tmux"
"let g:slime_python_ipython = 1

" ruby-vim
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_load_gemfile = 1
autocmd FileType ruby,eruby let ruby_space_errors = 1
autocmd FileType ruby,eruby let ruby_fold = 1
autocmd FileType ruby,eruby let ruby_spellcheck_strings = 1

" Autosave vim sessions
autocmd VimEnter * Obsession ~/.Session.vim

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
