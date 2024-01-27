return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  disabled=true, --********I've opted for just getting the lsp to find the .venv in the root directory. No longer need this plugin
  opts = {
    -- Your options go here
    -- name = "venv",
    parents = 0,
    search_workspace = true, -- this uses the lsp root directory (see :LspInfo)
    auto_refresh = true,
    --search = true, -- look in current directory/parents for venv
    --poetr_path = ".venv",
    name = {"venv",".venv"},
    --search_venv_managers = false
  },
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}
