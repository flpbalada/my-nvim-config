return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          cache_picker = {
            num_pickers = 5,
          },
          sorting_strategy = "ascending",
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = "top",
            mirror = true,
            width = 0.90,
            height = 0.90,
            preview_height = 0.6,
          },
          mappings = {
            i = {
              ["<C-l>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = "cycle_history_next",
              ["<C-p>"] = "cycle_history_prev",
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
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
          buffers = {
            initial_mode = "normal",
            sort_mru = true,
            ignore_current_buffer = true,
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
          live_grep = {
            hidden = true,
            file_ignore_patterns = { "node_modules/" },
          },
        },
      })
      local builtin = require("telescope.builtin")
      local action_state = require("telescope.actions.state")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>ú", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fH", builtin.search_history, { desc = "Search history" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
      vim.keymap.set("n", "<leader>gcc", builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Git buffer commits" })
    end,
  }
}
