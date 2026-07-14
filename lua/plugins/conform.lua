return {
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    config = function()
      local function has_biome_config(bufnr)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname == "" then
          return false
        end

        local dirname = vim.fs.dirname(bufname)
        return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = dirname, upward = true })[1] ~= nil
      end

      local function biome_or_prettier(bufnr)
        if has_biome_config(bufnr) then
          return { "biome" }
        end

        return { "prettier" }
      end

      require("conform").setup({
        formatters_by_ft = { -- Configure formatters for each file type
          javascript = biome_or_prettier,
          typescript = biome_or_prettier,
          javascriptreact = biome_or_prettier,
          typescriptreact = biome_or_prettier,
          css = { "prettier" },
          html = { "prettier" },
          json = biome_or_prettier,
          jsonc = biome_or_prettier,
          markdown = { "prettier" },
          lua = { "stylua" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          arduino = { "clang-format" },
        },
        notify_on_error = true,
      })
    end,
  },
}
