function! vimrc#lightline#Tabs() abort
  if tabpagenr('$') == 1
    return []
  endif
  return lightline#tabs()
endfunction

function! vimrc#lightline#Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! vimrc#lightline#Fileformat()
  if winwidth(0) <= 70 || empty(&fileencoding)
    return ''
  endif

  return &fileencoding . ' ' . WebDevIconsGetFileFormatSymbol()
endfunction

function! vimrc#lightline#NearestFunction()
  let function_name = get(b:, 'vista_nearest_method_or_function', '')
  if empty(function_name)
    return ''
  endif
  return ' ' . function_name
endfunction

function vimrc#lightline#Branch() abort
  let head = FugitiveHead()
  if empty(head)
    return ''
  endif
  return head . ' '
endfunction


function! vimrc#lightline#Filename()
  let filename = expand('%:t')
  if empty(filename)
    return '[Без имени]'
  endif
  if &readonly
    let filename .= g:lightline#bufferline#read_only
  elseif &modified
    let filename .= g:lightline#bufferline#modified
  endif
  return filename
endfunction
