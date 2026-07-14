return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx", "vimwiki" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", {
      "3rd/image.nvim",
      lazy = true,
      config = function()
        require("image").setup({
          backend = "kitty", -- Ghostty uses the kitty protocol
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { "markdown", "vimwiki" },
            },
          },
          max_width = 100,
          max_height = 12,
          window_overlap_clear_enabled = true,
        })
      end
    }
    },
    config = function()
      require("render-markdown").setup({
        preset = "none",
        anti_conceal = { enabled = true },
        latex = { enabled = false },
        yaml = { enabled = false },
        heading = {
          enabled = true,
          sign = false,
          icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " }, -- GitHub-style heading markers
          backgrounds = {                                                -- Colored backgrounds for each heading level
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
        },
        code = {
          enabled = true,
          sign = false,
          style = "language", -- Show language name for code blocks
          border = "thin",    -- Add border around code blocks
          width = "block",    -- Full-width code blocks
          left_pad = 2,
          right_pad = 2,
        },
        bullet = {
          icons = { "•", "◦", "▪", "▫" },
        },
        checkbox = {
          unchecked = { icon = "☐ " }, -- Unchecked task list item
          checked = { icon = "☑ " }, -- Checked task list item
        },
        callout = {
          note = { raw = "[!NOTE]", rendered = "📝 Note", highlight = "RenderMarkdownInfo" },
          tip = { raw = "[!TIP]", rendered = "💡 Tip", highlight = "RenderMarkdownSuccess" },
          important = { raw = "[!IMPORTANT]", rendered = "❗ Important", highlight = "RenderMarkdownHint" },
          warning = { raw = "[!WARNING]", rendered = "⚠️  Warning", highlight = "RenderMarkdownWarn" },
          caution = { raw = "[!CAUTION]", rendered = "🚨 Caution", highlight = "RenderMarkdownError" },
        },
      })
    end,
  }
}
