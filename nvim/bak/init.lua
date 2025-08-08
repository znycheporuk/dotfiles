-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap and setup lazy.nvim
require("config.lazy")
