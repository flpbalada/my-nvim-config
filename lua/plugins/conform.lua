return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = { -- Configure formatters for each file type
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          arduino = { "clang-format" },
        },
        format_on_save = {      -- Auto-format on save
          timeout_ms = 2000,    -- Maximum time to wait for formatting
          lsp_fallback = false, -- Prevent LSP fallback to avoid conflicting formatting
        },
      })
    end,
  },
}
