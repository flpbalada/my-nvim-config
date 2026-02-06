return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
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
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Set global capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Customize TypeScript/JavaScript LSP with inlay hints
      vim.lsp.config('ts_ls', {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      })

      -- Customize Lua LSP with Neovim settings
      vim.lsp.config('lua_ls', {
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

      -- Configure Arduino language server
      vim.lsp.config('arduino_language_server', {
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

      -- Increase timeout for Arduino language server
      vim.lsp.set_log_level("info")

      -- Enable LSP servers with file-type-specific lazy loading
      vim.lsp.enable({
        ts_ls = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        eslint = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        tailwindcss = { "html", "css", "tsx", "js", "markdown" },
        html = { "html", "htmldjango" },
        cssls = { "css", "scss" },
        lua_ls = { "lua" },
        arduino_language_server = { "arduino", "cpp", "c" },
        clangd = { "c", "cpp" },
      })

      -- Configure LspAttach handler once
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            -- Suppress errors from unknown workspace commands
            local orig_execute_command = vim.lsp.buf.execute_command
            vim.lsp.buf.execute_command = function(command)
              if command.command and command.command:match("_typescript") then
                return -- Silently ignore TypeScript-only commands
              end
              return orig_execute_command(command)
            end

            -- Auto-fix on save for ESLint
            if client.name == "eslint" then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                  pcall(vim.cmd, "EslintFixAll")
                end,
              })
            end
          end
        end,
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
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
