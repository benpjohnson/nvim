" contineprint_r(); comments when a newline is started
set comments=sr:/*,mb:*,ex:*/

" reverse the order of elements in an array
map <Leader>ar :s/^\s*\(.*\)\s*=>\s*\(.*\)\s*,/\2 => \1,/g<CR>gv=gv:Tab /=><CR>

" Don't scan included files
set complete-=i

" Force tab to 4 spaces
set shiftwidth=4

" Highlight embeded SQL queries
let php_sql_query=1

" PSR-2 complient indent
let g:PHP_vintage_case_default_indent = 1

" Lookup database table names from a dictionary
" FIXME: generate this on the fly
set dictionary-=$HOME/.dbtables dictionary+=$HOME/.dbtables

" NeoMake: Check PSR-2
let g:neomake_php_phpcs_args_standard = 'PSR2'

" NeoMake: Check for errors on write
autocmd! BufWritePost * Neomake

" Man: Use pman command for php statements
let g:vim_man_cmd="/usr/bin/pman"

" psysh repl prompt
map <A-p> :T psysh<CR>
