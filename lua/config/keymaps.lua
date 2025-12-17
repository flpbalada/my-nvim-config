-- Save without formatting
vim.keymap.set("n", "<leader>W", ":w<CR>", { desc = "Save file" })

-- Format and save (with import organization for TS/JS)
vim.keymap.set("n", "<leader>w", function()
  local bufname = vim.api.nvim_buf_get_name(0)

  -- Guard: require a file name to save
  if bufname == "" then
    vim.notify("Buffer has no file name. Use :w <filename> to save.", vim.log.levels.WARN)
    return
  end

  local filetype = vim.bo.filetype

  -- Organize imports only for TypeScript/JavaScript files
  if filetype == "typescript" or filetype == "javascript" or filetype == "typescriptreact" or filetype == "javascriptreact" then
    local params = {
      command = "_typescript.organizeImports",
      arguments = { bufname },
    }
    vim.lsp.buf.execute_command(params)

    -- Small delay to ensure organize imports completes before formatting
    vim.defer_fn(function()
      vim.lsp.buf.format()
      vim.cmd("w")
    end, 250)
    return
  end

  -- For all other files (including markdown), just format and save
  vim.lsp.buf.format()
  vim.cmd("w")
end, { desc = "Format and save" })

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>:bnext<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bD", ":bufdo bd<CR>", { desc = "Close all buffers" })

-- Visual mode: yank and reselect
vim.keymap.set("v", "<D-c>", '"+ygv', { desc = "Copy and reselect" })


-- Move lines with Alt+j/k
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move selection with Alt+j/k
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = "New tab" })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = "Close tab" })
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = "Next tab" })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = "Previous tab" })
vim.keymap.set('n', '<leader>t1', ':tabnext 1<CR>', { desc = "Go to tab 1" })
vim.keymap.set('n', '<leader>t2', ':tabnext 2<CR>', { desc = "Go to tab 2" })
vim.keymap.set('n', '<leader>t3', ':tabnext 3<CR>', { desc = "Go to tab 3" })

-- Window management
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to bottom window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to top window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Close window" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

-- Scrolling up and down to center of page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
