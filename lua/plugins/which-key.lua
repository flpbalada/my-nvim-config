return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local which_key = require("which-key")
      which_key.setup({
        preset = "helix",
        layout = {
          width = { min = 30, max = 60 },
          spacing = 3,
        },
      })
      which_key.add({
        { "<leader>b", group = "buffers" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>gx", group = "conflicts" },
        { "<leader>gh", group = "hunks" },
        { "<leader>t", group = "tabs" },
        { "<leader>w", group = "windows/write" },
      })
    end,
  },
}
