source ~/.vim/functions.vim

call pathogen#infect()


set nocompatible   " Disable vi-compatibility
set backspace=2
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
set rtp+=~/dotfiles/vim/bundle/powerline/bindings/vim
set nofoldenable    " disable folding
" let g:Powerline_symbols = 'fancy'

command -nargs=+ MapToggle call MapToggle(<f-args>)

set history=100         " keep 100 lines of history
set ruler               " show the cursor position

syntax on
syntax enable               " syntax highlighting
"set background=dark
"colorscheme solarized
"colorscheme darkblue
"colorscheme ron
"colorscheme wombat256
"colorscheme colorful256
"colorscheme desert256
"colorscheme oceanblack256
"colorscheme symfony

" Highlight variable colors
let g:hlvarhl="ctermbg=black ctermfg=red guifg=#ff0000 guibg=#000000 gui=bold"
set hlsearch            " highlight the last searched term

" Filetype plugins
filetype plugin on      " use the file type plugins
au BufNewFile,BufRead *.psgi set filetype=perl

set smartindent
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set nu
set viminfo='10,\"100,:20,%,n~/.viminfo

" set iskeyword=@,58
nmap _M :!open https://metacpan.org/module/<cword><CR>
nmap _H :!perlfind <cword><CR>

" move lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" create pastie, currently irrelevant
"nnoremap <C-p> :!curl -s -F data=@% http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>
"vnoremap <C-p> <esc>:'<,'>:w !curl -s -F data=@- http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>

" Copy & Pasta
vmap <C-c> :!xclip -f -sel clip<CR>
map <C-v> :-1r !xclip -o -sel clip<CR>`z

" Comment lines
source ~/dotfiles/vcomments.vim
map _{ :call Comment()<CR>
map _} :call Uncomment()<CR>

" git blame
" TODO rewrite this

vmap _S <esc>y :!git log -S'<C-R>"' -1 %<CR>
vmap _D <esc>y :!git log -S'<C-R>"' -1 -p %<CR>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" Support for scroll wheel
map <M-Esc>[62~ <MouseDown>
map! <M-Esc>[62~ <MouseDown>
map <M-Esc>[63~ <MouseUp>
map! <M-Esc>[63~ <MouseUp>
map <M-Esc>[64~ <S-MouseDown>
map! <M-Esc>[64~ <S-MouseDown>
map <M-Esc>[65~ <S-MouseUp>
map! <M-Esc>[65~ <S-MouseUp>

set mouse=v

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

" Function Keys
map       <F2> :!countperl %<CR>
" PerlTidy / Syntastic Check
map       <F3> :let t = winsaveview()<CR>:%!perltidy<CR>:w<CR>:call winrestview(t)<CR>:SyntasticCheck<CR>
vnoremap <F3> <esc>:'<,'>!perltidy<CR>:w<CR>
" Run the file
map       <F4> :!HARNESS_ACTIVE=1 perl -I lib/ %<CR>
map       <F5> :!HARNESS_ACTIVE=1 prove -MTest::Pretty -I lib/ %<CR>
" Run test harness
MapToggle <F7> hlsearch
MapToggle <F8> wrap

" TagBar
map       <F9> :TagbarOpenAutoClose<CR>
let g:tagbar_type_perl = {
	\ 'kinds' : [
		\ 'c:constants:1:0',
		\ 'f:formats:1:0',
		\ 'l:labels:0:1',
		\ 'p:packages:1:1',
		\ 's:subroutines:0:1',
		\ 'd:subroutine declartion [off]:1:0',
		\ 'w:roles:1:1',
		\ 'e:extends:1:0',
		\ 'b:bases:1:0',
		\ 't:parents:1:0',
		\ 'u:uses:1:0',
		\ 'r:requires:1:0',
		\ 'a:attributes:0:1',
	\ ]
\ }

" Syntastic commands
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
let g:syntastic_warning_symbol='⚠'
let g:syntastic_perl_checkers=['perl','perlcritic']
let g:syntastic_perl_perlcritic_args="--theme corvisa"

" Quick file switch
source ~/dotfiles/vim/plugin/blackjack_switch.vim
"let g:blackjack_path = "/home/maximilian.witte/workspace/blackjack/"
let g:blackjack_path = "/home/dev/workspace/lxi/"
"let g:shortcut_project_name = "Blackjack"
let g:shortcut_project_name = "Lexi"
nmap _O :call OpenBlackjackFile()<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR> 

" RainbowParen
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" EasyTags 
let g:easytags_auto_highlight = 1
let g:acp_behaviorPerlOmniLength = 0

highlight clear SignColumn

" taglist.vim (http://www.vim.org/scripts/script.php?script_id=273)
" let Tlist_Auto_Open = 1
" let Tlist_Auto_Update = 1
" let Tlist_Auto_Auto_Highlight_Tag = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Display_Tag_Scope = 1
" let tlist_perl_settings='perl;u:use;p:package;r:role;e:extends;c:constant;a:attribute;s:subroutine;l:label'
