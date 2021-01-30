vim.cmd('autocmd vimrc User visual_multi_mappings imap <buffer><expr> <CR> pumvisible() ? "<C-Y>" : "<Plug>(VM-I-Return)"')

vim.g.VM_mouse_mappings = true
vim.g.VM_show_warnings = false
vim.g.VM_silent_exit = true
vim.g.VM_set_statusline = 0
vim.g.VM_leader = '<Space><Space>'

vim.g.VM_Extend_hl = 'PmenuSel'
vim.g.VM_Cursor_hl = 'PmenuSel'

vim.g.VM_maps = {
  ['Increase'] = '<C-=>',
  ['Decrease'] = '<C-->',
  ['Find Subword Under'] = '<A-m>',
  ['Find Under'] = '<A-m>',
  ['Select All'] = '<A-a>',
  ['Add Cursor At Pos'] = '<A-i>',
  ['Reselect Last'] = '<A-r>',
  ['Mouse Cursor'] = '<A-LeftMouse>',
  ['Mouse Word'] = '<A-RightMouse>',
  ['Visual All'] = '<A-a>'
}
