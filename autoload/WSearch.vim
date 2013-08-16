" =============================================================================
" Author:        Oren Rozen                  
" =============================================================================


command! WSearchInit silent exec "!mkdir .WSearch/"

" function to create tag + site 
" site can have {WSearch} in the url to be replaced by the search word
command! -complete=custom,ListTags -nargs=+ WSearchSaveTagAndSite call WSearchSaveTagAndSite(<f-args>)
function! WSearchSaveTagAndSite(arg1, arg2)
	exec "!touch .WSearch/".a:arg1." && echo '".EscapeUrl(a:arg2)."' >> .WSearch/" .a:arg1
	silent exec "!touch .WSearch/.lastsearch && echo '".EscapeUrl(a:arg2)."' >> .WSearch/.lastsearch"
endfunction

command! -complete=custom,ListTags -nargs=1 WSearchShow call WSearchShow(<f-args>)
function! WSearchShow(arg1)
	echo system("tail -1 .WSearch/".a:arg1)
endfunction

command! -complete=custom,ListTags -nargs=1 WSearchRemoveTag call WSearchRemoveTag(<f-args>)
function! WSearchRemoveTag(arg1)
	silent exec "!rm .WSearch/".a:arg1
endfunction

command! -nargs=* WSearch call WSearch(<f-args>)
function! WSearch(...)
	let site = EscapeUrl(system("tail -1 .WSearch/.lastsearch"))
	if len(a:000) ==0
		let searchPattern = expand('<cword>')
		let escapedSearchPattern = searchPattern
	endif
	if len(a:000) >0
		let  escapedSearchPattern = join(a:000,'+')
		let  searchPattern = join(a:000,' ')
	endif
	let site = substitute(site, "{WSearch}" , escapedSearchPattern,"")
	silent exec "!open ".site
	let @* = searchPattern
	echo 'clipboard = '.searchPattern
endfunction


command! -complete=custom,ListTags -nargs=+ WSearchATag call WSearchATag(<f-args>)
function! WSearchATag(...)
	let site = EscapeUrl(system("tail -1 .WSearch/".a:1))
	if len(a:000) ==1
		let searchPattern = expand('<cword>')
	endif
	if len(a:000) >1
		let ls =copy(a:000)
		call remove(ls,0)
		let  escapedSearchPattern = join(ls,'+')
		let  searchPattern = join(ls,' ')
	endif
	echo site
	exec "!touch .WSearch/.lastsearch && echo '".expand(site)."' >> .WSearch/.lastsearch"
	let site = substitute(site, "{WSearch}" , escapedSearchPattern,"")
	silent exec "!open ".site
	let @* = searchPattern
	echo 'clipboard = '.searchPattern
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             private methods                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ListTags(A,L,P)
    return system("ls .WSearch/")
endfun

fun! EscapeUrl(url)
	let output = substitute(a:url , '#' , '\\#' ,'')
	let output = substitute(output , '%' , '\\%' ,'')
	return output
endfun
