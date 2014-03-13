" Vim filetype plugin file
" Last Change: 2014 Mar 13

if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1

set makeprg=jslint\ %
set errorformat=%-P%f,%E%>%\\s%##%n\ %m,%Z%.%#Line\ %l\\,\ Pos\ %c,%-G%f\ is\ OK.,%-Q

let s:cpo_save = &cpo
set cpo-=C

setlocal formatoptions-=t formatoptions+=croql

if exists('&ofu')
    setlocal omnifunc=javascriptcomplete#CompleteJS
endif

setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s

if has("gui_win32")
    let b:browsefilter="JavaScript files (*.js)\t*.js\nAll files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setl fo< ofu< com< cms<" 

let &cpo = s:cpo_save
unlet s:cpo_save
