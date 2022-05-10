" vim: set foldmethod=marker foldlevel=0 nomodeline:   " zr(open), zm(close)
" ============================================================================
" .vimrc of Yeongjun Kim {{{
" ============================================================================

:let s:darwin = has('mac')
let os=substitute(system('uname'), '\n', '', '')

" }}}
" =============================================================================
" VIM-PLUG BLOCK {{{
" =============================================================================
"
call plug#begin('~/.vim/plugged')

" Colors
Plug 'owickstrom/vim-colors-paramount'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Edit
Plug 'benmills/vimux' " vim과 tmux 연동하기 위한 플러그인
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim' "스페이스바 2번 누르면 실행되고 아직 이해 못함
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary',        { 'on': '<Plug>Commentary' }
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'beloglazov/vim-online-thesaurus' " 영영 사전 ons

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer --gocode-completer
  endif
endfunction
Plug 'valloric/youcompleteme', { 'for': ['c', 'cpp'], 'do': function('BuildYCM') }

" Browsing
"Plug 'Yggdroot/indentLine', "{ 'on': 'IndentLinesEnable' }
"autocmd! User indentLine doautocmd indentLine Syntax
Plug 'nathanaelkane/vim-indent-guides'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

if v:version >= 703
  "Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle'      }
endif

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif

" Lang
Plug 'nsf/gocode',                   { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'fatih/vim-go',                 { 'tag': '*' }
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'shmup/vim-sql-syntax'
Plug 'dearrrfish/vim-applescript'

if os == 'Darwin'
  Plug 'rizzatti/dash.vim',  { 'on': 'Dash' } " Dash와 연동
endif

" Lint
Plug 'w0rp/ale', { 'on': 'ALEEnable', 'for': ['ruby', 'sh'] }
"Plug 'scrooloose/syntastic'

call plug#end()

" }}}
" =============================================================================
"                              BASIC SETTINGS
" =============================================================================

set fencs=utf-8,cp949,euc-kr
set number                                                " show absolute line number of the current line
set ai smartindent
set sw=4 ts=4 softtabstop=4 
set expandtab smarttab
set laststatus=2                                          " always show status bar
set showcmd
" set visualbell
set backspace=indent,eol,start
set encoding=utf-8 fileencodings=utf-8                    " encoding
set nobackup nowritebackup noswapfile                     " no backup or swap
set hlsearch incsearch ignorecase smartcase               " search
set ruler                                                 " show cursor position in status bar
set cursorline
"set cursorcolumn
"set nocursorline
set history=500                                           " history size
set showmatch                                             " 자동 괄호맞쳐주기
set title
set showmode	                                          " show current mode
set t_Co=256
set clipboard=unnamed                                     " copy to clipboard

"highlight LineNr ctermfg=white ctermbg=234

" search options
let g:MultipleSearchMaxColors=8
hi Search0 ctermbg=blue guibg=blue ctermfg=white guifg=white
hi Search1 ctermbg=green guibg=green ctermfg=black guifg=black
hi Search2 ctermbg=magenta guibg=magenta ctermfg=white guifg=white
hi Search3 ctermbg=cyan guibg=cyan ctermfg=black guifg=black
hi Search4 ctermbg=brown guibg=brown ctermfg=white guifg=white
hi Search5 ctermbg=gray guibg=gray ctermfg=black guifg=black
hi Search6 ctermbg=red guibg=red ctermfg=white guifg=white

" Setting cursor, cursor line
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
    "let &t_ti.="\<Esc>]1337;HighlightCursorLine=true\x7"
    "let &t_te.="\<Esc>]1337;HighlightCursorLine=false\x7"
endif

" For MacVim
set noimd
set imi=1
set ims=-1

" ctags
set tags=./tags;/

" mouse
silent! set ttymouse=xterm2
set mouse=a
set nomousehide                                           " don't hide the mouse cursor while typing
set mousemodel=popup                                      " right-click pops up context menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Mappings
" see: http://blog.naver.com/PostView.nhn?blogId=nfwscho&logNo=220407221737
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

vnoremap <leader>c "*y

" Disable copy when delete character
nnoremap x "_x
nnoremap d "_d
vnoremap d "_d

" fomatting
" :%!python -m json.tool

" <F11> | Tagbar
if v:version >= 703
  inoremap <F11> <esc>:TagbarToggle<cr>
  nnoremap <F11> :TagbarToggle<cr>
  let g:tagbar_sort = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set background=dark
colorscheme paramount

hi Normal ctermbg=none " set custom background color

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_json_syntax_conceal = 0

let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" vim-fugitive
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" NERDTree
let NERDTreeWinPos='left'
noremap <c-\> :NERDTreeToggle<cr>
noremap \nf :NERDTreeFind<cr>
let NERDTreeShowHidden=1

" FZF
nmap <c-p> :FZF<cr>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlig

" Don't prompt to load ycm_extra_conf.py for YouCompleteMe; just load it.
let g:ycm_confirm_extra_conf = 0

let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
