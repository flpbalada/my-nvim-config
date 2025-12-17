return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true, -- Show blame on current line
        current_line_blame_opts = {
          delay = 300,
        },
      })
      vim.keymap.set("n", "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })
    end,
  },
}
