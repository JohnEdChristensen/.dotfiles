local config = require("plugins.configs.lspconfig") --default config

local on_attach = config.on_attach
local capabilities = config.capabilities
local util = require "lspconfig.util"

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach=on_attach,
  collectgarbage=capabilities,
  filetypes={"python"},
})

lspconfig.tsserver.setup{
  on_attach=on_attach,
  collectgarbage=capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
}
lspconfig.rust_analyzer.setup({
  on_attach=on_attach,
  collectgarbage=capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    cargo = {
      allFeatures = true,
    }
  }
})
