local commit_log_format = "%h%x1f%an%x1f%ae%x1f%s"

local function git_commit_entry_maker(opts)
	opts = opts or {}

	local entry_display = require("telescope.pickers.entry_display")
	local make_entry = require("telescope.make_entry")
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 8 },
			{ width = 22 },
			{ width = 30 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		return displayer({
			{ entry.value, "TelescopeResultsIdentifier" },
			entry.author,
			entry.email,
			entry.subject,
		})
	end

	return function(line)
		if line == "" then
			return nil
		end

		local sha, author, email, subject = line:match("([^\31]+)\31([^\31]*)\31([^\31]*)\31(.*)")
		if not sha then
			return nil
		end

		if subject == "" then
			subject = "<empty commit message>"
		end

		return make_entry.set_default_entry_mt({
			value = sha,
			ordinal = table.concat({ sha, author, email, subject }, " "),
			author = author,
			email = email,
			subject = subject,
			msg = subject,
			display = make_display,
			current_file = opts.current_file,
		}, opts)
	end
end

local function git_commit_picker_opts()
	local opts = {
		git_command = { "git", "log", "--pretty=format:" .. commit_log_format, "--", "." },
	}
	opts.entry_maker = git_commit_entry_maker(opts)

	return opts
end

local function git_current_file_commit_picker_opts()
	local opts = {
		git_command = { "git", "log", "--pretty=format:" .. commit_log_format, "--follow", "--" },
	}
	opts.entry_maker = git_commit_entry_maker(opts)

	return opts
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>ú",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>fH",
				function()
					require("telescope.builtin").search_history()
				end,
				desc = "Search history",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help tags",
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "List git branches",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits(git_commit_picker_opts())
				end,
				desc = "List git commits",
			},
			{
				"<leader>gC",
				function()
					require("telescope.builtin").git_bcommits(git_current_file_commit_picker_opts())
				end,
				desc = "List current file commits",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status()
				end,
				desc = "List changed files",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					cache_picker = {
						num_pickers = 5,
					},
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						prompt_position = "top",
						mirror = true,
						width = 0.90,
						height = 0.90,
						vertical = {
							preview_height = 0.6,
						},
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
							["dd"] = actions.delete_buffer,
						},
					},
				},
				pickers = {
					git_status = {
						layout_strategy = "horizontal",
						layout_config = {
							horizontal = {
								prompt_position = "top",
								preview_width = 0.6,
								width = 0.95,
								height = 0.9,
							},
						},
					},
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
		end,
	},
}
