return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "]h", function()
            gitsigns.nav_hunk("next")
          end, "Next changed hunk")
          map("n", "[h", function()
            gitsigns.nav_hunk("prev")
          end, "Previous changed hunk")
          map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk diff")
          map("n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
          map("n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")
          map("v", "<leader>ghs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Stage selected hunks")
          map("v", "<leader>ghr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Reset selected hunks")
          map("n", "<leader>ghb", function()
            gitsigns.blame_line({ full = true })
          end, "Show line blame")
          map("n", "<leader>gB", gitsigns.toggle_current_line_blame, "Toggle inline blame")
        end,
      })
    end,
  },
}
