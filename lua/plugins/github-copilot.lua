return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }
      vim.g.copilot_disable_on_commands = { "BufWritePre" }
      vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)', { desc = 'Copilot: Accept word' })
      vim.keymap.set('i', '<C-e>', '<Plug>(copilot-dismiss)', { desc = 'Copilot: Dismiss' })
      vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { desc = 'Copilot: Next suggestion' })
      vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { desc = 'Copilot: Previous suggestion' })
      vim.keymap.set('i', '<C-h>', '<Plug>(copilot-suggest)', { desc = 'Copilot: Suggest' })
      vim.keymap.set('i', '<C-m>', '<Plug>(copilot-accept-line)', { desc = 'Copilot: Accept line' })
    end,
  },
}
