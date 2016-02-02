" FZF
" TODO: Changed locally and changed on this branch
noremap <Leader>f :FZF .<CR>
noremap <C-p> :FZF .<CR>
noremap <Leader>m :FZFMru<CR>
noremap <Leader>b :FZFMru<CR>
noremap <Leader>B :FZF ~/bin<CR>
noremap <Leader>T :FZF ~/devel/tgit<CR>
noremap <Leader>D :FZF ~/devel/<CR>

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader>b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" Fugitive
" --------
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gl :Glog<CR>

" Ag
" --
nmap <Leader>gg :Ag --php 
nmap <Leader>ggw :Ag --php <cword><CR>
nmap <Leader>gr yiw:Ag --php '<c-r>"'<CR>

" PHP Documenter
" --------------
let g:pdv_template_dir = $HOME ."/.vim/templates_snip"
nmap <Leader>dd :call pdv#DocumentWithSnip()<CR>

" debugbydie 
" ----------
map <Leader>di :call Die()<CR>
map <Leader>dr :call RemoveDies()<CR>

" UltiSnips
" ---------
let g:UltiSnipsEditSplit="vertical"
let g:UltipsSnippetDirectories=["UltiSnips","snippets"]
let g:UltiSnipsExpandTrigger="<Tab>"

" vimwiki
" -------
let g:vimwiki_list = [{'path': '~/kb2/general', 'syntax': 'markdown', 'ext': '.md', 'index': 'home'}, {'path': '~/kb2/work', 'syntax': 'markdown', 'ext': '.md', 'index': 'home'}, {'path': '~/kb2/personal', 'syntax': 'markdown', 'ext': '.md', 'index': 'home'}, {'path': '~/kb2/project', 'syntax': 'markdown', 'ext': '.md', 'index': 'home'} ] 

" csv
" ---
" Fixing default highlights
hi CSVColumnEven ctermfg=188 ctermbg=234 guifg=#dcdccc guibg=#1f1f1f
hi CSVColumnOdd  ctermfg=188 ctermbg=234 guifg=#dcdccc guibg=#1f1f1f
hi CSVColumnHeaderEven ctermfg=188 ctermbg=234 guifg=#dcdccc guibg=#1f1f1f
hi CSVColumnHeaderOdd ctermfg=188 ctermbg=234 guifg=#dcdccc guibg=#1f1f1f

" Slimux / Neoterm
" ----------------

map <Leader>c :TREPLSend<CR>
let g:neoterm_size = 20
" FIXME: toggle
map <A-c> :Tclose<CR>
map <A-o> :Topen<CR>
map <Space><Space> :TREPLSend<CR>

map <Leader>ps :Test<CR>

" vimpipe
map <Leader>,vc :let b:vimpipe_command="

" vdebug
" ======
" Conflicts with the php-fpm port I tend to use
" let g:vdebug_options['port'] = 9300
map <Leader>bw :BreakpointWindow<CR>
map <Leader>br :BreakpointRemove *<CR>
map <Leader>bb :Breakpoint<CR>

" dbtables maps
nmap <Leader>dt :call dbtables#describe('')<CR>
nmap <Leader>dtt :FZFTables<CR>
let g:dbtables_dbcommand='mysql -uroot Core_DB'
let g:dbtables_mysqldump='mysqldump -uroot Core_DB'

" make test commands execute using neovim
let test#strategy = "neoterm"

" Tests
nmap <silent> <A-t> :TestNearest<CR>
nmap <silent> <A-T> :TestFile<CR>
nmap <silent> <A-a> :TestSuite<CR>
nmap <silent> <A-L> :TestLast<CR>
nmap <silent> <A-g> :TestVisit<CR>

" NeoMake
let g:neomake_php_phpcs_args_standard = 'PSR2'

" Signify
let g:signify_vcs_list = [ 'git', 'svn' ]
