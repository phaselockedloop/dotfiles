" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
"
hi clear
set background=dark
if exists("syntax_on")
 syntax reset
endif
let g:colors_name = "koehler2"
hi Normal		 cterm=NONE
hi Scrollbar	 cterm=NONE
hi Menu			 cterm=NONE
hi SpecialKey	 cterm=NONE ctermfg=darkred 
hi NonText		 cterm=NONE ctermfg=darkred 
hi Directory	 cterm=NONE ctermfg=brown 
hi ErrorMsg		 cterm=NONE ctermfg=white ctermbg=darkred 
hi Search		 ctermfg=white ctermbg=red 
hi MoreMsg		 cterm=NONE ctermfg=darkgreen	 
hi ModeMsg		 cterm=NONE 
hi LineNr		 cterm=NONE ctermfg=darkcyan	
hi Question		 cterm=NONE ctermfg=darkgreen	 
hi StatusLine	 cterm=NONE ctermfg=lightblue ctermbg=black 
hi StatusLineNC  ctermbg=lightblue 
hi Title		 cterm=NONE ctermfg=darkmagenta 
hi Visual		 cterm=NONE
hi WarningMsg	 cterm=NONE ctermfg=darkred 
hi Cursor		 cterm=NONE
hi Comment		 cterm=NONE ctermfg=cyan 
hi Constant		 cterm=NONE ctermfg=magenta 
hi Special		 cterm=NONE ctermfg=red 
hi Identifier	 ctermfg=brown 
hi Statement	 cterm=NONE ctermfg=yellow	 
hi PreProc		 ctermfg=darkmagenta 
hi Type			 cterm=NONE ctermfg=lightgreen 
hi Error		 ctermbg=black 
hi Todo			 ctermfg=black	ctermbg=darkcyan 
hi CursorLine	 cterm=underline
hi CursorColumn	 cterm=underline
hi MatchParen	 ctermfg=blue 
hi TabLine		 cterm=NONE ctermfg=lightblue ctermbg=white 
hi TabLineFill	 cterm=NONE ctermfg=lightblue ctermbg=white 
hi TabLineSel	 ctermbg=lightblue 
hi Underlined	 cterm=NONE,underline ctermfg=lightblue 
hi Ignore		 ctermfg=black ctermbg=black 
hi EndOfBuffer	 cterm=NONE ctermfg=darkred 
hi link IncSearch		Visual
hi link String			Constant
hi link Character		Constant
hi link Number			Constant
hi link Boolean			Constant
hi link Float			Number
hi link Function		Identifier
hi link Conditional		Statement
hi link Repeat			Statement
hi link Label			Statement
hi link Operator		Statement
hi link Keyword			Statement
hi link Exception		Statement
hi link Include			PreProc
hi link Define			PreProc
hi link Macro			PreProc
hi link PreCondit		PreProc
hi link StorageClass	Type
hi link Structure		Type
hi link Typedef			Type
hi link Tag				Special
hi link SpecialChar		Special
hi link Delimiter		Special
hi link SpecialComment	Special
hi link Debug			Special

" Extras
hi DiffAdd ctermfg=green ctermbg=black 
hi DiffChange ctermfg=green ctermbg=black
hi DiffText ctermfg=green ctermbg=black
hi DiffDelete ctermfg=white ctermbg=darkred
