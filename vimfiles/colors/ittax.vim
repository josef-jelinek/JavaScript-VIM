" Vim color file
" Last Change: 2014 Mar 13
" Acknowledgement: Based on Mustang by Henrique C. Alves (hcarvalhoalves@gmail.com)

set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "ittax"

hi Cursor       guifg=none    guibg=#626262 gui=none
hi CursorLine   guibg=#2D2D2D
hi CursorColumn guibg=#2D2D2D
hi Normal       guifg=#E2E2E5 guibg=#202020 gui=none
hi NonText      guifg=#808080 guibg=#303030 gui=none
hi LineNr       guifg=#808080 guibg=#000000 gui=none
hi StatusLine   guifg=#D3D3D5 guibg=#444444 gui=italic
hi StatusLineNC guifg=#939395 guibg=#444444 gui=none
hi VertSplit    guifg=#444444 guibg=#444444 gui=none
hi Folded       guibg=#384048 guifg=#A0A8B0 gui=none
hi Title        guifg=#F6F3E8 guibg=none    gui=bold
hi Visual       guifg=#FAF4C6 guibg=#3C414C gui=none
hi SpecialKey   guifg=#808080 guibg=#343434 gui=none
hi Search       guifg=#000000 guibg=#FFD700 gui=none
hi MatchParen   guifg=#D0FFC0 guibg=#2F2F2F gui=bold
hi Pmenu        guifg=#FFFFFF guibg=#444444
hi PmenuSel     guifg=#000000 guibg=#B1D631

" Syntax highlighting
hi Comment      guifg=#808080 gui=none
hi Todo         guifg=#8F8F8F gui=bold
hi Boolean      guifg=#B1D631 gui=none
hi String       guifg=#B1D631 gui=none
hi Identifier   guifg=#B1D631 gui=none
hi Function     guifg=#FFFFFF gui=bold
hi Type         guifg=#7E8AA2 gui=none
hi Statement    guifg=#7E8AA2 gui=none
hi Keyword      guifg=#FF9800 gui=none
hi Constant     guifg=#FF9800 gui=none
hi Number       guifg=#FF9800 gui=none
hi Special      guifg=#FF9800 gui=none
hi PreProc      guifg=#FAF4C6 gui=none
hi Todo         guifg=#000000 guibg=#E6EA50 gui=bold
