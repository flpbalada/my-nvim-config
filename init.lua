vim.g.mapleader = " "             -- Set leader key to space
vim.g.maplocalleader = " "        -- Set local leader key to space

vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Disable relative line numbers
vim.opt.mouse = "a"               -- Enable mouse support in all modes
vim.opt.ignorecase = true         -- Ignore case in search patterns
vim.opt.smartcase = true          -- Override ignorecase if search contains uppercase
vim.opt.hlsearch = false          -- Don't highlight search results
vim.opt.wrap = false              -- Don't wrap lines
vim.opt.breakindent = true        -- Preserve indentation in wrapped text
vim.opt.tabstop = 2               -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2            -- Number of spaces for each indentation level
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.opt.smartindent = true        -- Smart autoindenting on new lines
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes"        -- Always show sign column
vim.opt.updatetime = 250          -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 300          -- Time to wait for mapped sequence
vim.opt.scrolloff = 8             -- Minimal number of lines to keep above/below cursor
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.undofile = true           -- Enable persistent undo
vim.o.guifont = "Fira_Code:h12"


require("config.lazy")
require("config.keymaps")
