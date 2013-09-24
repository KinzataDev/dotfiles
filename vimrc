source ~/.vim/functions.vim

call pathogen#infect()

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
" let g:Powerline_symbols = 'fancy'
set rtp+=~/dotfiles/vim/bundle/powerline/bindings/vim
set nofoldenable    " disable folding

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
colorscheme desert256
"colorscheme oceanblack256
"colorscheme symfony

set hlsearch            " highlight the last searched term
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
nmap _M :!xdg-open https://metacpan.org/module/<cword><CR>
nmap _H :!perlfind <cword><CR>

" move lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" create pastie
nnoremap <C-p> :!curl -s -F data=@% http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>
vnoremap <C-p> <esc>:'<,'>:w !curl -s -F data=@- http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>

vmap <C-c> :!xclip -f -sel clip<CR>
map <C-v> mz:-1r !xclip -o -sel clip<CR>`z

" Comment lines
source ~/dotfiles/vcomments.vim
map _{ :call Comment()<CR>
map _} :call Uncomment()<CR>

" git blame
vmap _B :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

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

vmap _S <esc>y :!git log -S'<C-R>"' -1 %<CR>
vmap _D <esc>y :!git log -S'<C-R>"' -1 -p %<CR>

" Function Keys
MapToggle <F2> paste
" PerlTidy / Syntastic Check
map       <F3> :let t = winsaveview()<CR>:%!perltidy<CR>:w<CR>:call winrestview(t)<CR>:SyntasticCheck<CR>
vnoremap <F3> <esc>:'<,'>!perltidy<CR>:w<CR>
" Run the file
map       <F4> :!perl -I lib/ %<CR>
" Run test harness
map       <F5> :w<CR>:!script -c 'HARNESS_ACTIVE=1 prove -lvmfo %' /tmp/last-prove.txt<CR>:!less -R -F +G /tmp/last-prove.txt<CR>
map       <F6> :!less -R /tmp/last-prove.txt<CR>
MapToggle <F7> hlsearch
MapToggle <F8> wrap
" TagBar
map       <F9> :TagbarOpenAutoClose<CR>


" Syntastic commands
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
let g:syntastic_warning_symbol='⚠'
let g:syntastic_perl_checkers=['perl','perlcritic']
let g:syntastic_perl_perlcritic_args="--theme corvisa"	


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

" taglist.vim (http://www.vim.org/scripts/script.php?script_id=273)
" let Tlist_Auto_Open = 1
" let Tlist_Auto_Update = 1
" let Tlist_Auto_Auto_Highlight_Tag = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Display_Tag_Scope = 1
" let tlist_perl_settings='perl;u:use;p:package;r:role;e:extends;c:constant;a:attribute;s:subroutine;l:label'
