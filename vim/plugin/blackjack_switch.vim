fun! OpenBlackjackFile()
	call inputsave()
	let _input = input('Open: ')
	call inputrestore()

	let args = split(_input, ' ')

	call LoadFile(args[0], args[1])
endf


fun! LoadFile(path, file)
	if a:path ==? "rr"
		let s:new_file = g:blackjack_path . "lib/" . g:shortcut_project_name . "/Role/Result/" . a:file . ".pm"
	elseif a:path ==? "rrs"
		let s:new_file = g:blackjack_path . "lib/" . g:shortcut_project_name . "/Role/ResultSet/" . a:file . ".pm"
	elseif a:path ==? "sr"
		let s:new_file = g:blackjack_path . "lib/" . g:shortcut_project_name . "/Schema/Result/" . a:file . ".pm"
	elseif a:path ==? "srs"
		let s:new_file = g:blackjack_path . "lib/" . g:shortcut_project_name . "/Schema/ResultSet/" . a:file . ".pm"
	elseif a:path ==? "c"
		let s:new_file = g:blackjack_path . "lib/" . g:shortcut_project_name . "/Controller/" . a:file . ".pm"
	elseif a:path ==? "td"
		let s:new_file = g:blackjack_path . "lib/Test/" . g:shortcut_project_name . "/Data/" . a:file . ".pm"
	endif

	:execute "rightbelow vsplit " . s:new_file
endf
