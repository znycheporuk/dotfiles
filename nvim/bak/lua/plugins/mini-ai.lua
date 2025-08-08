return {
  "echasnovski/mini.ai",
  version = false,
  event = "VeryLazy",
  opts = {
    n_lines = 50,
    custom_textobjects = {
      f = function()
        return require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
      end,
      c = function()
        return require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
      end,
    },
  },
}