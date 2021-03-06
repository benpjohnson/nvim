" FIXME: dedupe with markdown
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

" FIXME: should be in a liquibase filetype as we are abusing XML :(
autocmd BufNewFile,BufRead,BufReadPost * call TextEnableCodeSnip('sql',   '<sql',   '</sql', 'SpecialComment')
autocmd BufNewFile,BufRead,BufReadPost * call TextEnableCodeSnip('sql',   '<rollback',   '</rollback', 'SpecialComment')

" autocmd FileType xml setlocal commentstring='-- %s'
