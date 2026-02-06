return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false, -- Show blame on current line
      })
      vim.keymap.set("n", "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })
    end,
  },
}
