return {
  {
    -- theme
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local options = {
        colours_override = function(palette)
          return palette
        end,
        -- Include other necessary options here if needed
      }
      local theme = "dark" -- or "light", depending on your preference
      local theme_colors = require("everforest.colours").generate_palette(options, theme)
      vim.api.nvim_set_hl(0, "WinBar", { fg = theme_colors.green, bg = theme_colors.bg1 })

      require("everforest").setup({
        vim.cmd.colorscheme 'everforest'
      })
    end,
  },
  -- color html colors
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,          -- #RGB hex codes
          RRGGBB = true,       -- #RRGGBB hex codes
          names = true,        -- "Name" codes like Blue or blue
          RRGGBBAA = true,     -- #RRGGBBAA hex codes
          AARRGGBB = true,     -- 0xAARRGGBB hex codes
          rgb_fn = true,       -- CSS rgb() and rgba() functions
          hsl_fn = true,       -- CSS hsl() and hsla() functions
          css = true,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                               -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
          -- all the sub-options of filetypes apply to buftypes
          buftypes = {},
        },
      })
    end,
  },
}
