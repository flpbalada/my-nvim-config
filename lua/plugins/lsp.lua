return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "tailwindcss",
          "html",
          "cssls",
          "lua_ls",
          'arduino_language_server',
          'clangd'
        },
        automatic_enable = false,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "biome",
          "clang-format",
        },
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 24,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Set global capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Customize TypeScript/JavaScript LSP with inlay hints
      vim.lsp.config('ts_ls', {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayFunctionParameterTypeHints = false,
            },
          },
        },
      })

      -- Customize Lua LSP with Neovim settings
      vim.lsp.config('lua_ls', {
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
          },
        },
      })

      vim.lsp.config('eslint', {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })

      vim.lsp.config('tailwindcss', {
        filetypes = { "html", "css", "typescriptreact", "javascriptreact", "typescript", "javascript", "markdown", "mdx" },
      })

      vim.lsp.config('html', {
        filetypes = { "html", "htmldjango" },
      })

      vim.lsp.config('cssls', {
        filetypes = { "css", "scss", "less" },
      })

      -- Configure Arduino language server
      vim.lsp.config('arduino_language_server', {
        filetypes = { "arduino", "cpp", "c" },
        cmd = {
          "arduino-language-server",
          "-cli-config", os.getenv('HOME') .. '/Library/Arduino15/arduino-cli.yaml',
          "-fqbn", "esp32:esp32:esp32",
          "-skip-libraries-discovery-on-rebuild",
        },
        init_options = {
          clangdLoggingLevel = "error",
        },
      })

      vim.lsp.config('clangd', {
        filetypes = { "c", "cpp" },
      })

      -- Enable LSP servers with file-type-specific lazy loading
      vim.lsp.enable({ "ts_ls", "eslint", "tailwindcss", "html", "cssls", "lua_ls", "arduino_language_server", "clangd" })

      -- Configure LspAttach handler once
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.name ~= "eslint" then
            return
          end

          vim.keymap.set("n", "<leader>cE", "<cmd>EslintFixAll<CR>", { buffer = args.buf, desc = "ESLint fix all" })
        end,
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 2,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.INFO] = '»',
            [vim.diagnostic.severity.HINT] = '›',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          max_width = 80,
        },
      })



      -- LSP keybindings
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
    end,
  },


}
