require('formatter').setup({
  filetype = {
    lua = {
      function()
        return {
          exe = 'stylua',
          args = { '--search-parent-directories', '-' },
          stdin = true,
        }
      end,
    },
    markdown = {
      function()
        return {
          exe = 'prettier',
          args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    cpp = {
      function()
        return {
          exe = 'clang-format',
          stdin = true,
        }
      end,
    },
  },
})
