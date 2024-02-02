return {
  -- telescope
  -- a nice seletion UI also to find and open files
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local previewers = require("telescope.previewers")
      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 100000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end
      telescope.setup({
        defaults = {
          buffer_previewer_maker = new_maker,
          file_ignore_patterns = {
            "node_modules",
            "%_files/*.html",
            "%_cache",
            ".git/",
            "site_libs",
            ".venv/*", -- may need to remove if I want to look at venvs!
          },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<esc>"] = actions.close,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = false,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!.git/*",
              "--glob",
              "!**/.Rproj.user/*",
              "--glob",
              "!_site/*",
              "--glob",
              "!docs/**/*.html",
              "-L",
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
        },
      })
      -- telescope.load_extension('fzf')
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
      telescope.load_extension("dap")
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end
        return "📷[" .. reg .. "]"
      end

      require("lualine").setup({
        options = {
          section_separators = "",
          component_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode", macro_recording },
          lualine_b = { "branch", "diff", {
            "diagnostics",
            symbols = {
              error = ' ',
              warn = ' ',
              hint = ' ',
              info = ' '
            }
          } },
          lualine_c = { "searchcount" },
          -- lualine_b = {},
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree" },
      })
    end,
  },

  -- {
  --   "nanozuki/tabby.nvim",
  --   config = function()
  --     require("tabby.tabline").use_preset("active_wins_at_end")
  --   end,
  -- },

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {}
    end
  },

  --
  -- {
  --   'dstein64/nvim-scrollview',
  --   config = function()
  --     require('scrollview').setup({
  --       current_only = true,
  --     })
  --   end
  -- },

  -- { 'RRethy/vim-illuminate' }, -- highlight current word

  -- filetree
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<c-n>", ":NvimTreeToggle<cr>", desc = "toggle nvim-tree" },
    },
    lazy = false,
    config = function()
      -- vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticWarnIcon', { fg = "#ffffff" })
      -- vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticErrorIcon', { fg = "#ffffff" })
      -- vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticInfoIcon', { fg = "#ffffff" })
      -- vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticHintIcon', { fg = "#ffffff" })
      require("nvim-tree").setup({
        disable_netrw = true,
        update_focused_file = {
          enable = true,
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        diagnostics = {
          enable = true,
        },
      })
    end,
  },
  -- show keybinding help window
  { "folke/which-key.nvim" },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>lo", ":SymbolsOutline<cr>", desc = "symbols outline" },
    },
    config = function()
      require("symbols-outline").setup()
    end,
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
      })
    end,
  },
  -- show diagnostics list
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        signs = {
          error = " ",
          warning = " ",
          hint = " ",
          information = " "
        }
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = true,
    config = function()
      local highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterRed',
        'RainbowDelimiterOrange',
        'RainbowDelimiterCyan',

      }
      local options = {
        colours_override = function(palette)
          return palette
        end,
        -- Include other necessary options here if needed
      }
      local theme = "dark" -- or "light", depending on your preference
      local theme_colors = require("everforest.colours").generate_palette(options, theme)

      -- Use the mapped colors
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = theme_colors.red })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = theme_colors.yellow })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = theme_colors.blue })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = theme_colors.orange })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = theme_colors.green })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = theme_colors.purple })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = theme_colors.aqua })
      vim.api.nvim_set_hl(0, "RainbowRedScope", { fg = theme_colors.red })
      vim.api.nvim_set_hl(0, "MyScope", { fg = theme_colors.purple })
      -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['local'],
        },
        highlight = highlight
      }
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- change order to change change highlighting order
      local hooks = require "ibl.hooks"
      -- colored indents
      --hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level)
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_tab_indent_level)
      require("ibl").setup({
        -- in kitty.conf I added the follwoing to make the underline connect
        -- to the | char. and have the same thickness as the default bar
        -- modify_font underline_position +2
        -- modify_font underline_thickness +1
        -- indent = {char =  "▏"}, -- thinnest bar. see :help ibl.config.indent
        --indent = { highlight = highlight}, --
        scope = {
          --highlight = "MyScope",
          show_start = false,
          show_end = false
        },
        indent = { repeat_linebreak = true }
      })
      --hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup({
        quarto = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (fenced_code_block) @codeblock
                ]]
          ),
          codeblock_highlight = "CodeBlock",
          treesitter_language = "markdown",
        },
      })
    end,
  },

  {
    "3rd/image.nvim",
    event = "VeryLazy",
    config = function()
      -- Requirements
      -- https://github.com/3rd/image.nvim?tab=readme-ov-file#requirements
      local backend = "kitty"

      local shell
      if vim.fn.has("nvim-0.10.0") == 1 then
        -- print('nvim >= 0.10')
        shell = function(command)
          local obj = vim.system(command, { text = true }):wait()
          if obj.code ~= 0 then
            return nil
          end
          return obj.stdout
        end
      else
        -- print('nvim < 0.10')
        shell = function(command)
          command = table.concat(command, " ")
          local handle = io.popen(command)
          if handle == nil then
            return nil
          end
          local result = handle:read("*a")
          handle:close()
          return result
        end
      end

      -- check if imagemagick is available
      if shell({ "convert", "-version" }) == nil then
        print("imagemagick is not available")
        return
      end

      if backend == "kitty" then
        -- check if kitty is available
        local out = shell({ "kitty", "--version" })
        if out == nil then
          print("kitty is not available")
          return
        end
        local kitty_version = out:match("(%d+%.%d+%.%d+)")
        if kitty_version == nil then
          print("kitty version is not available")
          return
        end
        local v = vim.version.parse(kitty_version)
        local minimal = vim.version.parse("0.30.1")
        if v and vim.version.cmp(v, minimal) < 0 then
          print("kitty version is too old")
          return
        end
      end
      local tmux = vim.fn.getenv("TMUX")
      if tmux ~= vim.NIL then
        -- tmux uses number.number.(maybe letter)
        -- e.g. 3.3a
        -- but 3.3 comes before 3.3a
        -- so we replace a with 1
        local offset = 96
        local out = shell({ "tmux", "-V" })
        if out == nil then
          print("tmux is not available")
          return
        end
        out = out:gsub("\n", "")
        local letter = out:match("tmux %d+%.%d+([a-z])")
        local number
        if letter == nil then
          number = 0
        else
          number = string.byte(letter) - offset
        end
        local version = out:gsub("tmux (%d+%.%d+)([a-z])", "%1." .. number)
        local v = vim.version.parse(version)
        local minimal = vim.version.parse("3.3.1")
        if v and vim.version.cmp(v, minimal) < 0 then
          print("tmux version is too old")
          return
        end
      end
      -- setup
      -- Example for configuring Neovim to load user-installed installed Lua rocks:
      --$ luarocks --local --lua-version=5.1 install magick
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

      -- check if magick luarock is available
      local ok, magick = pcall(require, "magick")
      if not ok then
        print("magick luarock is not available")
        return
      end
      if os.getenv("TERM") ~= "xterm-kitty" then
        return
      end

      require("image").setup({
        backend = backend,
        integrations = {
          markdown = {
            enabled = true,
            -- clear_in_insert_mode = true,
            download_remote_images = true,
            -- only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki", "quarto" },
          },
        },
        max_width = 100,
        max_height = 40,
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true,  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
          },
          view = "mini"
        },
        -- {
        --   filter = {
        --     event = "msg_show",
        --     kind = "",
        --     find = "written",
        --   },
        --   opts = { skip = true },
        -- },
        -- {
        --   filter = {
        --     event = "notify",
        --     kind = "info",
        --   },
        --   opts = { skip = true },
        -- },
      },
      -- views = {
      --   cmdline_popup = {
      --     border = {
      --       style = "none",
      --       padding = { 2, 3 },
      --     },
      --     filter_options = {},
      --     win_options = {
      --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      --     },
      --   },
      -- },

    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}
