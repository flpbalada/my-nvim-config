return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { -- Languages to install parsers for
          "typescript",
          "tsx",
          "javascript",
          "html",
          "css",
          "json",
          "lua",
          "vim",
          "markdown",
          "markdown_inline",
          "c",
          "cpp",
        },
        highlight = { enable = true }, -- Enable treesitter-based syntax highlighting
        indent = { enable = true },    -- Enable treesitter-based indentation
        autotag = { enable = true },   -- Enable auto-closing and renaming of HTML tags
      })
    end,
  },
}
