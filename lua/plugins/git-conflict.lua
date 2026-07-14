return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
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
      vim.keymap.set("n", "<leader>gxo", "<Plug>(git-conflict-ours)", { desc = "Use current change" })
      vim.keymap.set("n", "<leader>gxt", "<Plug>(git-conflict-theirs)", { desc = "Use incoming change" })
      vim.keymap.set("n", "<leader>gxb", "<Plug>(git-conflict-both)", { desc = "Use both changes" })
      vim.keymap.set("n", "<leader>gx0", "<Plug>(git-conflict-none)", { desc = "Delete both changes" })
      vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Previous conflict" })
      vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Next conflict" })
      vim.keymap.set("n", "<leader>gxl", ":GitConflictListQf<CR>", { desc = "List merge conflicts" })
    end,
  },
}
