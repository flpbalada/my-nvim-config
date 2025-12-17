return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")         -- Load completion engine
      local luasnip = require("luasnip") -- Load snippet engine

      cmp.setup({
        snippet = {                       -- Configure snippet expansion
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip to expand snippets
          end,
        },
        mapping = cmp.mapping.preset.insert({                -- Completion keybindings
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- Scroll docs up
          ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- Scroll docs down
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion window
          ["<C-k>"] = cmp.mapping.select_prev_item(),        -- Move up in completion menu
          ["<C-l>"] = cmp.mapping.select_next_item(),        -- Move down in completion menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
          ["<Tab>"] = cmp.mapping(function(fallback)         -- Tab to cycle through completions
            if cmp.visible() then
              cmp.select_next_item()                         -- Select next item if menu is open
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()                       -- Expand or jump to next snippet field
            else
              fallback()                                     -- Otherwise insert tab
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({ -- Completion sources in priority order
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Cmdline completions for commands (:)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })

      -- Cmdline completions for search (/)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
    end,
  },
}
