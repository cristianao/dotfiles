syntax on
filetype plugin indent on

" ======= VimPlug Plugins ========

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Code style and linters
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
" Code search and indexing
Plug 'mileszs/ack.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
" Language auto-complete support
Plug 'shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'vim-scripts/pythoncomplete'
Plug 'fatih/vim-go'
" External plugin dependencies
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Test runners
Plug 'alfredodeza/pytest.vim'
" JSX support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()


" Plugin Settings

" Vim JSX
let g:jsx_ext_required = 1

"Deoplete and Deoplete Jedi
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python'
let g:deoplete#sources#jedi#show_docstring = 1

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_pattern_options = {
\   '\.(js|jsx|vue)$': {
\       'ale_linters': {
\           'vue': ['eslint'],
\           'jsx': ['eslint'],
\           'js': ['eslint'],
\       },
\   },
\   '\.py$': {
\       'ale_linters': {'python': ['flake8']},
\   }
\}

" fzf.vim
set tags=.git/tags
let g:fzf_tags_command = 'ctags -R'
let g:fzf_files_options = '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1

" ack
let g:ackprg = 'ag --vimgrep'

" neocomplete
let g:acp_enableAtStartup = 0
let g:deoplete#enable_at_startup = 1

" Mapping
let mapleader=","

" Setting python path to use current project bin
let $PYTHONPATH = getcwd().':'.$PYTHONPATH

" Preferences
set hidden
set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set ts=4
set laststatus=2
set shiftwidth=4
set shiftround
set expandtab
set term=xterm
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.pyc,*.bak,*.class,*.o,*.a
set title
set visualbell
set noerrorbells
set nobackup
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list
set pastetoggle=<F2>
set number

filetype plugin indent on

" Python Settings
if has('autocmd')
    autocmd filetype python set expandtab
endif

" Easy window navigation
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-right> <C-w>l
map <C-up> <C-w>k
map <C-p> :Files<cr>

" Tab window management
nnoremap <Tab> :tabn<cr>
nnoremap <S-Tab> :tabp<cr>
nnoremap <leader><Tab> :tabclose<cr>
nnoremap <leader><S-Tab> :tabonly<cr>

" Indentation Block Bindings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap ; :w !pbcopy<CR><CR>

" Cleanup search 
nmap <silent> ,/ :nohlsearch<CR>

" Toggle Tagbar
noremap <leader>q :TagbarToggle<CR>

" Search CTags using FZF Files
nnoremap <leader>. :Tags<cr>
nnoremap <leader>/ :Ag<cr>
nnoremap <leader>b :call fzf#run({'source': map(range(1, bufnr('$')), 'bufname(v:val)'),'sink': 'e', 'down': '30%'})<cr>
nnoremap <leader>c :let @/ = ""<cr>
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Refresh Tags
map <f12> :!$HOME/.git_template/hooks/ctags <cr>

" Shortcut for sudo tee on :w
cmap w!! w !sudo tee % >/dev/null

" Auto Triggers 
autocmd VimEnter * command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
augroup FileTypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    au BufNewFile,BufRead *.vue set filetype=javascript.jsx
augroup END

" Color Scheme
colorscheme default
