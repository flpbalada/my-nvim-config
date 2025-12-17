return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-l>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<c-d>"] = require('telescope.actions').delete_buffer,
            },
            n = {
              ["l"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["dd"] = require('telescope.actions').delete_buffer,
            },
          },
        },
        pickers = {
          find_files = {
            sort_mru = true,
            theme = "dropdown",
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
          buffers = {
            initial_mode = "normal",
            sort_mru = true,
            ignore_current_buffer = true,
            theme = "dropdown",
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
          live_grep = {
            theme = "dropdown",
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
        },
      })
      local builtin = require("telescope.builtin") -- Load telescope builtins

      vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>ú", builtin.live_grep, { desc = "Grep" })

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fH", builtin.search_history, { desc = "Search history" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Git buffer commits" })
    end,
  }
}
