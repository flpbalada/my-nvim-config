return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,     -- Use default buffer-local mappings (o, t, b, 0, n, p)
        default_commands = true,     -- Enable commands like GitConflictChooseOurs
        disable_diagnostics = false, -- Keep diagnostics enabled
        list_opener = 'copen',       -- Command to open quickfix list
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        }
      })

      -- Global keymaps for resolving conflicts
      vim.keymap.set("n", "<leader>gco", "<Plug>(git-conflict-ours)", { desc = "Choose ours" })
      vim.keymap.set("n", "<leader>gct", "<Plug>(git-conflict-theirs)", { desc = "Choose theirs" })
      vim.keymap.set("n", "<leader>gcb", "<Plug>(git-conflict-both)", { desc = "Choose both" })
      vim.keymap.set("n", "<leader>gc0", "<Plug>(git-conflict-none)", { desc = "Choose none" })
      vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Previous conflict" })
      vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Next conflict" })
      vim.keymap.set("n", "<leader>gcl", ":GitConflictListQf<CR>", { desc = "List conflicts" })
    end,
  },
}
