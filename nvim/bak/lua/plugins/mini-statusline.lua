return {
  "echasnovski/mini.statusline",
  version = false,
  event = "VeryLazy",
  opts = {
    use_icons = true,
    content = {
      active = function()
        local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
        local git = require("mini.statusline").section_git({ trunc_width = 40 })
        local diff = require("mini.statusline").section_diff({ trunc_width = 75 })
        local diagnostics = require("mini.statusline").section_diagnostics({ trunc_width = 75 })
        local lsp = require("mini.statusline").section_lsp({ trunc_width = 75 })
        local filename = require("mini.statusline").section_filename({ trunc_width = 140 })

        local location = require("mini.statusline").section_location({ trunc_width = 75 })
        local search = require("mini.statusline").section_searchcount({ trunc_width = 75 })

        return require("mini.statusline").combine_groups({
          { hl = mode_hl,                  strings = { mode } },
          { hl = "MiniStatuslineDevinfo",  strings = { git, diff, diagnostics, lsp } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { search, location } },
        })
      end,
      inactive = function()
        local filename = require("mini.statusline").section_filename({ trunc_width = 140 })
        return require("mini.statusline").combine_groups({
          { hl = "MiniStatuslineFilename", strings = { filename } },
        })
      end,
    },
    set_vim_settings = true,
  },
}