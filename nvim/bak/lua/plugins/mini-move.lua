return {
  "echasnovski/mini.move",
  version = false,
  event = "VeryLazy",
  opts = {
    mappings = {
      -- Move visual selection in Visual mode
      left = "<M-h>",
      right = "<M-l>",
      down = "<M-j>",
      up = "<M-k>",
      
      -- Move current line in Normal mode
      line_left = "<M-h>",
      line_right = "<M-l>",
      line_down = "<M-j>",
      line_up = "<M-k>",
    },
    options = {
      reindent_linewise = true,
    },
  },
}