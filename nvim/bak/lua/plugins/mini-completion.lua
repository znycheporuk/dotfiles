return {
  "echasnovski/mini.completion",
  version = false,
  event = "InsertEnter",
  opts = {
    lsp_completion = {
      source_func = "completefunc",
      auto_setup = true,
      process_items = function(items, base)
        return items
      end,
    },
    mappings = {
      force_twostep = "<C-Space>",
      force_fallback = "<A-Space>",
    },
    window = {
      info = { height = 25, width = 80, border = "none" },
      signature = { height = 25, width = 80, border = "none" },
    },
    delay = { completion = 100, info = 100, signature = 50 },
    fallback_action = "<C-x><C-n>",
    set_vim_settings = true,
  },
}