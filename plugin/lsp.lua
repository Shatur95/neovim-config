if vim.g.started_by_firenvim == true then
  return
end

local lspconfig = require('lspconfig')
local lsp_signature = require('lsp_signature')

-- LSP status
local lsp_status = require('lsp-status')
lsp_status.config({
  status_symbol = '',
  current_function = false,
  diagnostics = false, -- Will be displayed via lualine
})
lsp_status.capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_status.register_progress()

-- Buffer with LSP settings
local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  lsp_signature.on_attach({
    floating_window = false,
    hint_prefix = ' ',
  })

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-LeftMouse>', '<Cmd>Telescope lsp_definitions theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>Telescope lsp_definitions theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<Cmd>Telescope lsp_code_actions theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', '<Cmd>Telescope lsp_range_code_actions theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>Telescope lsp_references theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'go', '<Cmd>Telescope lsp_workspace_symbols theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gO', '<Cmd>Telescope lsp_document_symbols theme=get_dropdown<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', { noremap = true })

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-s>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })

  if vim.fn.exists('ClangdSwitchSourceHeader') then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<Cmd>ClangdSwitchSourceHeader<CR>', { noremap = true })
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-=>', '<Cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true })
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-=>', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', { noremap = true })
  end
end

-- Language servers configuration
lspconfig.clangd.setup({
  cmd = { 'clangd', '--background-index', '--cross-file-rename', '--header-insertion=never', '--suggest-missing-includes', '--pch-storage=memory' },
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true,
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
})

lspconfig.sumneko_lua.setup({
  cmd = { 'lua-language-server' },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
})

lspconfig.cmake.setup({
  capabilities = lsp_status.capabilities,
  on_attach = on_attach,
})

-- Icons
local kinds = require('vim.lsp.protocol').CompletionItemKind
kinds[kinds.Text] = ' Text'
kinds[kinds.Method] = 'ƒ Method'
kinds[kinds.Function] = ' Function'
kinds[kinds.Constructor] = ' Constructor'
kinds[kinds.Field] = 'ﰠ Field'
kinds[kinds.Variable] = ' Variable'
kinds[kinds.Class] = ' Class'
kinds[kinds.Interface] = ' Interface'
kinds[kinds.Module] = ' Module'
kinds[kinds.Property] = ' Property'
kinds[kinds.Unit] = ' Unit'
kinds[kinds.Value] = ' Value'
kinds[kinds.Enum] = ' Enum'
kinds[kinds.Keyword] = ' Keyword'
kinds[kinds.Snippet] = '﬌ Snippet'
kinds[kinds.Color] = ' Color'
kinds[kinds.File] = ' File'
kinds[kinds.Reference] = ' Reference'
kinds[kinds.Folder] = ' Folder'
kinds[kinds.EnumMember] = ' EnumMember'
kinds[kinds.Constant] = ' Constant'
kinds[kinds.Struct] = ' Struct'
kinds[kinds.Event] = ' Event'
kinds[kinds.Operator] = ' Operator'
kinds[kinds.TypeParameter] = ' TypeParameter'

-- Diagnistic signs
vim.fn.sign_define('LspDiagnosticsSignError', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '' })
