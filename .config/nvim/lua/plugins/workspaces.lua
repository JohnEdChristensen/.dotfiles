return {
  -- {
  -- 	"gnikdroy/projections.nvim",
  -- 	keys = {
  -- 		{
  -- 			"<leader>fp",
  -- 			function()
  -- 				vim.cmd("Telescope projections")
  -- 			end,
  -- 		},
  -- 	},
  -- 	config = function()
  -- 		vim.opt.sessionoptions:append("localoptions") -- Save localoptions to session file
  -- 		require("projections").setup({
  --        workspaces = {
  --          "~/dev",
  --          "~/dev/python",
  --        },
  --        patterns = {".git","pyproject.toml"},
  -- 			store_hooks = {
  -- 				pre = function()
  -- 					-- nvim-tree
  -- 					local nvim_tree_present, api = pcall(require, "nvim-tree.api")
  -- 					if nvim_tree_present then
  -- 						api.tree.close()
  -- 					end
  --
  -- 					-- neo-tree
  -- 					if pcall(require, "neo-tree") then
  -- 						vim.cmd([[Neotree action=close]])
  -- 					end
  -- 				end,
  -- 			},
  -- 		})
  --
  -- 		-- Bind <leader>fp to Telescope projections
  -- 		require("telescope").load_extension("projections")
  --
  -- 		-- Autostore session on VimExit
  -- 		local Session = require("projections.session")
  -- 		vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  -- 			callback = function()
  -- 				Session.store(vim.loop.cwd())
  -- 			end,
  -- 		})
  --
  -- 		-- Switch to project if vim was started in a project dir
  -- 		local switcher = require("projections.switcher")
  -- 		vim.api.nvim_create_autocmd({ "VimEnter" }, {
  -- 			callback = function()
  -- 				if vim.fn.argc() == 0 then
  -- 					switcher.switch(vim.loop.cwd())
  -- 				end
  -- 			end,
  -- 		})
  -- 	end,
  -- },
  {
    "coffebar/neovim-project",
    enabled = true,
    opts = {
      projects = { -- define project roots
        "~/dev/*",
        "~/.config/*",
      },
      last_session_on_startup = false,
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
}
