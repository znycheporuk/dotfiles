return {
  "echasnovski/mini.comment",
  version = false,
  event = "VeryLazy",
  opts = {
    options = {
      custom_commentstring = nil,
      ignore_blank_line = false,
      start_of_line = false,
      pad_comment_parts = true,
    },
    mappings = {
      comment = "gc",
      comment_line = "gcc",
      comment_visual = "gc",
      textobject = "gc",
    },
    hooks = {
      pre = function() end,
      post = function() end,
    },
  },
}