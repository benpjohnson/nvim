" tabs
noremap <A-l> gt
noremap <A-h> gT

noremap <Leader>to <ESC>:tabonly<CR>
" Open the current buffer in another tab
noremap <Leader>tt <ESC>:tab split<CR>
noremap <Leader>c <ESC>:tabclose<CR>

" neovim bonus key!
map <a-1> 1gt
map <a-2> 2gt
map <a-3> 3gt
map <a-4> 4gt
map <a-5> 5gt
map <a-6> 6gt
map <a-7> 7gt
map <a-8> 8gt
map <a-9> 9gt

" tab next/previous
map <Leader>l gt
map <Leader>h gT

" new tab
map <Leader>t <ESC>:tabnew<CR>

" Open a new SQL tab 
map <Leader>ts <ESC>:call DisposibleBuffer('sql')<CR>
" Open a new PHP tab 
map <Leader>tp <ESC>:tabnew +set\ filetype=php<CR>
" Open a new PHP window
map <Leader>vp <ESC>:vert new +set\ filetype=php<CR>
map <Leader>h <ESC>:new<CR>

" gnome-vim specific remap copy/paste to something sensible
" use alt instead of shift as it will override c-v for some 
" stupid reason I can't recall
nmap <C-A-V> "+gp
imap <C-A-V> <ESC><C-V>i
vmap <C-A-C> "+y 

" F3 toggle paste setting
set pastetoggle=<F3>
map <F4> :Test<CR>
" f6 to make
noremap <F6> :make<CR>

" edit vimrc 
map <Leader>er :exec "e " . resolve(expand($MYVIMRC))<CR>
" edit keymaps
map <Leader>ek :exec "e " . $NVIM . "/keymaps.vim"<CR>  
" edit plugin settings
map <Leader>ep :exec "e " . $NVIM . "/plugin-settings.vim"<CR>  
" edit keymaps settings
map <Leader>ef :exec "e " . $NVIM . "/filetype.vim"<CR>  
" edit Ultisnipts
map <Leader>eu :UltiSnipsEdit<CR>
" edit todo list
map <Leader>et :e ~/todo.txt<CR>
" edit local rc file
map <Leader>el :exec "e " . $NVIM . "/nvim.local"<CR>
" edit php.vim
map <Leader>epp :exec "e " . $NVIM . "/ftplugin/php.vim"<CR>
" edit .zshrc
map <Leader>ez :e ~/.zshrc<CR>
" edit .mrconfig for vim
map <Leader>em :e ~/.vim/.mrconfig<CR>

" edit awesomerc
map <Leader>ea :exec "e " . $HOME . "/.config/awesome/rc.lua"<CR>

" edit work in progress
map <Leader>ew :exec "e " . $NVIM . "/wip.vim"<CR>

" source vimrc and local if it's about
map <Leader>sr :source $MYVIMRC \| sil! source $NVIM . "/nvim.local"<CR>

" make '<Leader>e' (in normal mode) give a prompt for opening files
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Write quickly
map <Leader>w :windo! w<CR>

" friendly vert split new file
map <Leader>v :vert botright new<cr>

" insert from screen 
noremap <Leader>< :r $HOME/.screen-exchange<CR>

set showmode

" Yank current filename to the unnamed register
nmap cp :let @" = expand("%:t")<CR>

" Yank relative to the current dir
nmap ccp :let @" = expand("%:.") . ":" . line(".")<CR>

" Yank full path
nmap ccc :let @" = expand("%:p")<CR>

" directory navigation
nmap up :cd ..<CR>:pwd<CR>

" cd to the path of the current file
map <Leader>cd :exe 'cd ' . expand ("%:p:h")<CR>

" lcd version (cd only in the local window)
map <Leader>lcd :exe 'lcd ' . expand ("%:p:h")<CR>

" quickfix shortcuts
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

" Send inline SQL to /tmp/q
vmap <Leader>q :w! /tmp/q<CR>

" Open my cheatsheet
nmap <Leader>ec :vsp ~/kb2/general/cheat/vim-editor.md<CR>

" FIXME: This should use a template or something
"
nmap <Leader>fp :setf php<CR>I<?php<CR><Esc>
nmap <Leader>fs :setf sql<CR>
nmap <Leader>fb :setf sh<CR>I#!/bin/bash<CR># <Esc>

" Create or edit the file under the cursor 
map <leader>gf :e <cfile><cr>

" Jump to tag in new vertical split
nmap <Leader>vt "zyiw:vert stjump <C-r>"<CR>

" Playing with
inoremap jk <esc>

" use ctrl + hjkl in command mode
cnoremap <c-h> <Left>
cnoremap <c-j> <Down>
cnoremap <c-k> <Up>
cnoremap <c-l> <Right>

" Resize windows like awesomewm
nmap <leader>h 10<c-w><
nmap <leader>l 10<c-w>>

"nmap <Leader>n :bn<CR>
" Find stuff
nmap <Leader>ff :execute "Ggrep " .  expand('%:t')<CR>
nmap <Leader>z :execute "vert stjump " .  expand('<cword>')<CR>

nmap <Leader>x :close<CR>
nmap <Leader>X :bd!<CR>

nmap <Leader>r :redraw!<CR>

nmap <Leader>p yaW | let @"="print_r(" . @" . ");"

map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Started playing with FZF
map <Leader>V :FZF ~/.vim/<CR>
