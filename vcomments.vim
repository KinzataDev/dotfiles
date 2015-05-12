function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'pm' || ext == 'pl' || ext == 't' || ext == 'yml'
    silent s/^/\#/
  elseif ext == 'js'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  elseif ext == 'xml'
    silent s/^/<!--/
	silent s/$/-->/
  elseif ext == 'tt'
    silent s/^/\/\//
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py' || ext == 'pm' || ext == 'pl' || ext == 't' || ext == 'yml'
    silent s/^\#//
  elseif ext == 'js'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  elseif ext == 'xml'
    silent s/^<!--//
	silent s/-->//
  elseif ext == 'tt'
    silent s/^\/\///
  endif
endfunction
