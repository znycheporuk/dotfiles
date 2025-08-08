return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = "auto",
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
  },
  config = function(_, opts)
    -- Detect system theme on macOS
    local function get_system_appearance()
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()
        return result:match("Dark") and "dark" or "light"
      end
      return "dark"
    end
    
    -- Set vim background based on system theme
    vim.o.background = get_system_appearance()
    
    -- Override flavour based on detected theme
    if vim.o.background == "light" then
      opts.flavour = "latte"
    else
      opts.flavour = "mocha"
    end
    
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}