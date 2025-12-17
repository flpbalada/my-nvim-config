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

      -- Enable all LSP servers (uses nvim-lspconfig defaults + our customizations)
      vim.lsp.enable({ "ts_ls", "eslint", "tailwindcss", "html", "cssls", "lua_ls", "arduino_language_server" })

      -- Auto-fix on save for ESLint
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                pcall(vim.cmd, "EslintFixAll")
              end,
            })
          end
        end,
      })

      -- Add this inside the LspAttach autocmd callback (around line 81)
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
          end

          if client and client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                pcall(vim.cmd, "EslintFixAll")
              end,
            })
          end
        end,
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 2,
          format = function(diagnostic)
            local message = diagnostic.message:match("^[^\n]*")
            if #message > 40 then
              message = message:sub(1, 37) .. "..."
            end
            return message .. " [<leader>d] or [<leader>ca]"
          end,
        },
        signs = true,
        underline = true,         -- Underline errors
        update_in_insert = false, -- Don't update diagnostics while typing
        severity_sort = true,     -- Sort by severity
        float = {
          border = "rounded",
          source = "always", -- Show the source (eslint, typescript, etc.)
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
