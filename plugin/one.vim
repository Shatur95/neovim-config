let g:one_allow_italics = 1

colorscheme one

call one#highlight('DiffRemoved', '', 'bg', '')
call one#highlight('DiffAdded', '', 'bg', '')
call one#highlight('Constant', '56b6c2', '', '')
call one#highlight('LspDiagnosticsErrorSign', 'be5046', '', '')
call one#highlight('LspDiagnosticsWarningSign', 'd19a66', '', '')
call one#highlight('LspDiagnosticsInformationSign', '98c379', '', '')
call one#highlight('LspDiagnosticsHintSign', 'e5c07b', '', '')

highlight! LspDiagnosticsUnderlineError gui=undercurl cterm=undercurl guisp=#be5046
highlight! LspDiagnosticsUnderlineHint gui=undercurl cterm=undercurl guisp=#d19a66
highlight! LspDiagnosticsUnderlineInfo gui=undercurl cterm=undercurl guisp=#98c379
highlight! LspDiagnosticsUnderlineWarning gui=undercurl cterm=undercurl guisp=#e5c07b
