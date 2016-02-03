" fzf
set rtp+=~/.fzf

" Could this just run bin/???
map <a-e> :call fzf#run({'source': ['ls'], 'sink' : '!'})<CR>

" FIXME: handle selected range + optional argument (:help a:0) to override type
" FIXME: my own SQL formatter
function! Format(type)
  "FIXME: case
  "FIXME: handle selections
  if a:type == 'sql'
    exec "%!perl -MMysql::PrettyPrinter -e 'Mysql::PrettyPrinter->passthrough'"
  endif

  if a:type == 'json'
    exec "%!/usr/local/bin/python2.7 -mjson.tool"
  endif
  if a:type == 'xml'
    exec "%!xmlstarlet fo"
  endif

  " detect file format
  " look for a formatter
  " define Format call
  " json via python, sql
endfunction

function! FormatFromType()
  call Format(&filetype)
endfunction

function! GotoFileWithLineNum() 
    " filename under the cursor 
    let file_name = expand('<cfile>') 
    if !strlen(file_name) 
        echo 'NO FILE UNDER CURSOR' 
        return 
    endif 

    " look for a line number separated by a : 
    if search('\%#\f*:\zs[0-9]\+') 
        " change the 'iskeyword' option temporarily to pick up just numbers 
        let temp = &iskeyword 
        set iskeyword=48-57 
        let line_number = expand('<cword>') 
        exe 'set iskeyword=' . temp 
    endif 

    " edit the file 
    exe 'e '.file_name 

    " if there is a line number, go to it 
    if exists('line_number') 
        exe line_number 
    endif 
endfunction 

map gf :call GotoFileWithLineNum()<CR> 
map gsf :sp<CR>:call GotoFileWithLineNum()<CR>

" move to php.vim
" FIXME: make whitespace highlight global?? Can achieve this with a check
" in php.vim before defining it
function! ToggleStaticAnalysis()
	if !exists('g:staticAnalysis')
		" Clear ExtraWhitespace
		exec "silent! match ExtraWhitespace"
		let g:staticAnalysis = 1
	else
		" Redefine whitespace check
		exec "silent! match ExtraWhitespace /\s\+$/"
		unlet g:staticAnalysis
	endif

	exec "silent SyntasticToggleMode"
	exec "redraw!"
endfunction

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! PastePsr2()
    " write the contents of the buffer to a temp file
    " Run cs fixer on it
    " Other crap
    " Read it back in
    " paste
endfunction

" Attempt to fix formatting with patterns
function! PhpFormat() range
    " First part of an if
    sil execute ":s/if\s*(\s*/if ("
    " going to need some basic parsing perhaps pipe to PHP + recursive regex
    " to match brackets
endfunction

" Let me create an adhoc buffer I won't be prompted to save for queries/etc.
function! DisposibleBuffer(filetype)
    " Split & open.
    let bufname = "[Scratch " . a:filetype . "] " . strftime("%d/%m/%y %H:%M:%S")
    silent execute "tabnew" . bufname
    silent execute "set filetype=" . a:filetype

    let scratchbuffer = bufnr(bufname, 1)
    call setbufvar(scratchbuffer, "&swapfile", 0)
    call setbufvar(scratchbuffer, "&buftype", "nofile")
endfunction

" can we autocreate classes/etc?
" Prompt for class name
" create a new php buffer and name it for the Class name
" save to pwd by default and use ctrlp to move to sub dir if required
" function! PhpClass(
"     let class = expand("<cword>")
"     silent execute "vert new " . bufname
"
"    Python << EOF
"    import sys, vim
"    new_path = vim.eval("expand('g:UltiSnipsPythonPath')")
"    sys.path.append(new_path)
"    from UltiSnips import UltiSnips_Manager
"    UltiSnips_Manager.expand()
"    EOF
"    return ""
"
" endfunction

function! BuildTags()
endfunction

" Probably need a "server" version of the PHP parser to get this one
function! CurrentFunction()
python << endpython
from phply import phplex
vim.command('echomsg "test"')
endpython
endfunction

function! FormatSql()
python << endpython
import sqlparse
vim.command('echomsg "test"')

#print sqlparse.format('select * from foo where id in (select id from bar);', reindent=True, keyword_case='upper')
endpython
endfunction

"TODO: CtlP-my functions to keep an index of useful stuf I can't remember aka. emacs search stuff
"TODO: CtrlPGitBranch: jump to all changes that occured on this branch
" Grab parent revision since last reabseline etc
" DO  git diff --name-only 8030fa4515187ffe959c7622468102008d78f321.. << " probably numstat
" on enter diff with parent
"

"
"TODO: CtrlPUltisnips would be handy

function! InsertRandomValueFromFile(filename)
    let value=substitute(system("perl -e 'srand; rand($.) < 1 && ($line = $_) while <>; print $line;' " . a:filename . ""),"\n","","")
    " setline(line('.'), getline(line('.')) . " " . value)
    execute "normal i" . value
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" FIXME: track open pane id
" FIXME: bump up/down height

fun! RunUnder()
    if !g:opened
        call OpenUnder()
    endif
    exec("!tmux send-keys -t 1 'php " . expand("%") . "'\r")
endfun

" FIXME: toggle support
fun! OpenUnder()
    let g:opened=1
    exec("sil! !tmux split-window -p 22 -t 2 && tmux selectp -t 0")
endfun

fun! CloseUnder()
    let g:opened=0
    exec("sil! !tmux killp -t 1")
endfun

function! KillSwapFiles()
    exec("sil! !rm -rf ~/.vim_backup/*.swp")
    exec("redraw!")
endfunction

" Could I vcsh from here too?
function! TGitCommit()
    let message = input("Message: ")
    if message == "" 
        echom "Aborted!"
    else
        exec("sil! !tgit-commit -m '" . message . "'")
        exec("redraw!")
        echom "Committed"
    endif
endfunction
map <Leader>cc :call TGitCommit()<CR>


function! AlignChained() range "
    let range = a:firstline . "," . a:lastline
    execute range . "Tabularize /^[^->]*/l0"
    echom ":" . range . "Tabularize /^[^->]*/l0<CR>"
endfunction  

" if has("multi_byte")
"     set lcs=tab: ⇥
" else
"     set lcs=tab:>-
" endif


fun! CompleteMonths(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find months matching with "a:base"
        let res = []
        for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfun
set completefunc=CompleteMonths

" Mr plugin in progress!
function! Mr(args)
    " Currently using T()
    " FIXME: use proper vars"
    execute "T cd ~/.vim && mr " . a:args
endfunction
command! -nargs=1 Mr call Mr("<args>")

" function! Lb(args)
"     execute "T make 
" endfunction
" command -nargs=1 Lb call Lb("<args")

" MrPlug benekastah/neomake
" Push from vimrc to bundle
function! MrPlug(args)
"mr config bundle/neomake checkout="git clone https://github.com/benekastah/neomake.git" 'skip=[ "$1" = push ]'
endfunction

" function! MrCo
" endfunction
" function MrRm
" Remove config entry
" rm -rf files
" endfunction

" Vcsh command
" could autocomand maybe when opening vim files then fugitive stuff



" TODOS
" .mrconfig as ini
" command to add to mrconfig and download in one go
" neoterm + fallback to regular shell
" fugitive style interactive for disable/cleanup/etc could be useful


" First letter of runner's name must be uppercase
let test#runners = {'php': ['Phpunit']}

set rtp+=~/.fzf
let list_of_open_window = range(1,winnr('$')) 

" FZF Fun
nnoremap <silent> <Leader>d :call fzf#run({
\   'down': '40%',
\   'sink': 'vert diffs' })<CR>

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()

" Playing with repeating last TREPLSend
function! s:repel_repeat()

endfunction
map <Leader>c :call fzf#run({'source': g:cds, 'sink': 'cd'})<CR>

nnoremap <silent> <Leader>m :call fzf#run({
\   'source': 'sed "1d" $HOME/.cache/neomru/file',
\   'sink': 'e '
\ })<CR>
