return {
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git", -- also try out "git_branch"
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>a", "<cmd>Grapple toggle<cr>",          desc = "Grapple toggle tag" },
      { "<leader>p", "<cmd>Grapple toggle_tags<cr>",     desc = "Grapple open tags window" },
      { "<leader>k", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
      { "<leader>j", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
      { "<leader>+", "<cmd>Grapple select index=1<cr>",  desc = "Grapple select tag 1" },
      { "<leader>ě", "<cmd>Grapple select index=2<cr>",  desc = "Grapple select tag 2" },
      { "<leader>š", "<cmd>Grapple select index=3<cr>",  desc = "Grapple select tag 3" },
      { "<leader>č", "<cmd>Grapple select index=4<cr>",  desc = "Grapple select tag 4" },
      { "<leader>ř", "<cmd>Grapple select index=5<cr>",  desc = "Grapple select tag 5" },
    },
  },
}
