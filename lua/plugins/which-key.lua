return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "helix",
        layout = {
          width = { min = 30, max = 60 },
          spacing = 3,
        },
      })
    end,
  },
}
