return {
  {
    "folke/zen-mode.nvim",
    opts = {},
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.65,
          width = 0.68,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = true,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
          }
        },
        plugins = {
          twilight = { enabled = true },
          gitsigns = { enabled = false },
        }
      })
      vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>")
    end,
  }
}
