set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Other vundle plugins
" Keep Plugin commands between vundle#begin/end.
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vividchalk'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'sjl/tslime.vim'
Plugin 'vim-scripts/pythoncomplete'
Plugin 'wgibbs/vim-irblack'
Plugin 'tpope/vim-endwise'
Plugin 'vim-scripts/taglist.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/syntastic'
Plugin 'Rip-Rip/clang_complete'
Plugin 'scrooloose/nerdcommenter'
Plugin 'floobits/floobits-neovim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'sophacles/vim-processing'
Plugin 'jceb/vim-orgmode'
Plugin 'sunset'
Plugin 'kburdett/vim-nuuid'

"" Clojure things
"Plugin 'vimclojure'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-static'
Plugin 'guns/vim-clojure-highlight'
Plugin 'typedclojure/vim-typedclojure'
Plugin 'tpope/vim-leiningen'
Plugin 'dgrnbrg/vim-redl'


" Plugin 'vim-pandoc/vim-pandoc'

" Examples / reference
" ====================
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
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





" All the custom things
" =====================

" Replaced by Vundle
" call pathogen#infect()

let mapleader = ","
let maplocalleader = "\\"

"set backupdir=~/.vim.bkp

" Awesome rad maps...
map <leader>P :Plain<enter>
map <leader>p "+p
map <leader>Y "+yy
map <leader>m :Mail<enter>
map <leader>M :Mail<enter>
map <leader>r :res 
map <leader>/ /asdf<enter>

map <C-s> :w<enter>
" Shouldn't need this one, but just in case I haven't yet
map <C-S> :w<enter>

" yank to X clipboard
vmap <leader>y "+y

" Remove tailing white spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" don't stage - git helper for removing things from staging on add -e
"vmap <leader>ds <line1>,<line2>call DontStage()<enter>
function! DontStage() range
  execute a:firstline . "," . a:lastline . 's/^-/ /'
  execute a:firstline . "," . a:lastline . 'g/^+/d'
endfunction
vmap <leader>ds :call DontStage()<enter>


" Clojure fireplace etc goodies
vmap e :Eval<enter>
vmap E :Eval!<enter>
map E Ve
map <leader>e :%Eval<enter>

" Something else helpful for clojure (edn really)
au BufNewFile,BufRead *.edn set filetype=clojure

" Other highlighting things
let g:clojure_align_subforms = 0
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
let g:clojure_special_indent_words = 'deftype,defrecord,reify,proxy,extend-type,extend-protocol,letfn,go-loop,go'


" Some goodies Andrew shared for cursorlines
map <leader>h :set cursorline! cursorcolumn!<CR>
" By default on...
:set cursorline! cursorcolumn!


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


" Set sconsstruct files to python filetype, and set up a few special functions for syntax highlighting
au BufNewFile,BufRead SCons* set filetype=python
syn keyword sconsEnv Command, Alias, Variables, SlurmEnvironment, PathVariable
hi link sconsEnv Function


au BufNewFile,BufRead less set filetype=css

set guioptions-=m "Remove menu bar
set guioptions-=T "Remove tool bar
set guifont=Monospace\ 8

syntax on
set t_Co=16
call togglebg#map("<F4>")
colorscheme solarized


let vimrplugin_screenplugin = 0
let vimrplugin_underscore = 0

" Make supertab ignore usage on fresh lines
"function! CleverTab()
   "if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      "return "\<Tab>"
   "else
      "return "\<C-N>"
   "endif
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>

" Attempting to get omni complete to run through super tab contextually
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

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
map <leader>T :NERDTreeToggle <CR>
map <leader>t :NERDTreeTabsToggle <CR>
" Was liking having drawer open up automatically, bit it's actually kind of annoying... Might modify later
"autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.RData$']

" Stuff for working with tabs + windows
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

map <C-n> :call MoveToPrevTab()<CR>
map <C-m> :call MoveToNextTab()<CR>
map <C-B> :call MoveToPrevTab()<CR>
map <C-M> :call MoveToNextTab()<CR>
" Don't know why I have to call this...
unmap <enter>


" Disables pandoc folding - kinda neet though. Might be cool to activate this later
let g:pandoc_no_folding = 1


if has("gui_running")
  set lines=70 columns=118
endif

" Sunset settings - for automatically changing background based on sunlight
let g:sunset_latitude = 47.6097
let g:sunset_longitude = -122.3331
let g:sunset_utc_offset = -8



"" Generate and insert uuids
"fu! GenerateUUID()
 
"python << EOF
"import uuid
"import vim
 
"# output a uuid to the vim variable for insertion below
"vim.command("let generatedUUID = \"%s\"" % str(uuid.uuid4()))
 
"EOF
 
"" insert the python generated uuid into the current cursor's position
":execute "normal i" . generatedUUID . ""
 
"endfunction
 
""initialize the generateUUID function here and map it to a local command
"map <Leader>U :call GenerateUUID()<CR>

let g:nuuid_no_mappings = 1
map <Leader>U <Plug>Nuuid



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
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt,mds} setf markdown
  " Make handlebars look ok
  au BufRead,BufNewFile *.{handlebars,hbs} setf html
  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript
  " Treat todo files like markdown
  au BufNewFile,BufRead *.todo set ft=markdown
  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
  " and for js
  au FileType javascript setlocal softtabstop=2 tabstop=2 shiftwidth=2
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
