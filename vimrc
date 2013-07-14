call pathogen#infect()

let mapleader = ","
let maplocalleader = "\\"


" Awesome rad maps...

map <leader>P :Plain<enter>
map <leader>p "+p
map <leader>Y "+yy
map <leader>m :Mail<enter>
map <leader>M :Mail<enter>

map <C-s> :w<enter>
" Shouldn't need this one, but just in case I haven't yet
map <C-S> :w<enter>

" yank to X clipboard
vmap <leader>y "+y


" don't stage - git helper for removing things from staging on add -e
"vmap <leader>ds <line1>,<line2>call DontStage()<enter>
function! DontStage() range
  execute a:firstline . "," . a:lastline . 's/^-/ /'
  execute a:firstline . "," . a:lastline . 'g/^+/d'
endfunction
vmap <leader>ds :call DontStage()<enter>



" I'm going to use these Alt-binding now for moving through text more easily
" when I'm wrapping, but these (for now, unless I figure something clever out)
" are only going to work in Gvim.
vmap <A-j> gj
vmap <A-k> gk
vmap <A-4> g$
vmap <A-6> g^
vmap <A-0> g^
nmap <A-j> gj
nmap <A-k> gk
nmap <A-4> g$
nmap <A-6> g^
nmap <A-0> g^

"au BufNewFile,BufRead SCons* set filetype=scons
au BufNewFile,BufRead SCons* set filetype=python
" the scons type is supposed to inherit from the python type, but there are a
" bunch of things that don't seem to inherit properly, so for now, should just
" use the python type until this is fixed.

au BufNewFile,BufRead less set filetype=css

set guioptions-=m "Remove menu bar
set guioptions-=T "Remove tool bar

syntax on
set t_Co=16
call togglebg#map("<F5>")
set background=light
colorscheme solarized


let vimrplugin_screenplugin = 0
let vimrplugin_underscore = 0

" Because it's annoying when shifting for ':' lingers for w or q and you think
" you've saved but haven't....
command! W w
command! Q q

command! Mail set ft=mail
" Should really set this up as a separate ft
command! Plain set spell linebreak wrap tw=1111111

command! Reload source ~/.vimrc
command! Erc split ~/.vimrc

set noea


" Spell check settings

hi SpellBad cterm=bold ctermbg=black

set textwidth=110


" NERDTree setup
map <leader>t :NERDTreeToggle <CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.RData$']

" Disables pandoc folding - kinda neet though. Might be cool to activate this later
let g:pandoc_no_folding = 1


if has("gui_running")
  set lines=70 columns=110 
endif

" Sunset settings - for automatically changing background based on sunlight
let g:sunset_latitude = 47.61
let g:sunset_longitude = 122.33
let g:sunset_utc_offset = -7



"" The below was all snagged from janus. Moving away..
"" ===================================================
""

filetype plugin indent on

set number " Show line numbers
set ruler " Show line and column number
set encoding=utf-8 " Set default encoding to UTF-8

set nowrap " don't wrap lines
set tabstop=2 " a tab is two spaces
set shiftwidth=2 " an autoindent (with <<) is two spaces
set expandtab " use spaces, not tabs
set backspace=indent,eol,start " backspace through everything in insert mode


" Consider doing
" :set list
" :set listchars=""
" :set listchars=tab:\ \
" :set listchars=trail:.

set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase "searches are case insensitive
set smartcase " ... unless they contain at least one capital letter

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore 'compiled' python files
set wildignore+=*.pyc
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*


""
"" File types

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

if has("autocmd")
" In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab
" Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
" Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript
" make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
" Remember last location in file, but not for commit messages.
" see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
  " XXX - Custom...
  au FileType mail setlocal wrap softtabstop=4 tabstop=4 shiftwidth=4 tw=999999 linebreak spell
endif


if has("statusline") && !&cp
  set laststatus=2 " always show the status bar

" Start the status line
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif


" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q
" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"<CR>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" format the entire file - XXX Not sure what this does
nmap <leader>fef ggVG=
