-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.opt.guicursor = ""
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
require("mini.statusline").setup()

require("cmp").setup({
  enabled = false,
})

if vim.g.neovide then
  vim.o.guifont = "CommitMono_Nerd_Font"
  vim.g.neovide_scroll_animation_length = 0.15
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)

  if vim.g.neovide then
    vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
    vim.keymap.set("v", "<D-c>", '"+y') -- Copy
    vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  end
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_floating_blur_amount_x = 0
  vim.g.neovide_floating_blur_amount_y = 0
  vim.g.neovide_floating_shadow = false
end

local cmp_enabled = false
vim.api.nvim_create_user_command("ToggleAutoComplete", function()
  if cmp_enabled then
    require("cmp").setup({
      enabled = false,
    })
    require("cmp").setup.buffer({ enabled = false })
    cmp_enabled = false
  else
    require("cmp").setup({
      enabled = true,
    })
    require("cmp").setup.buffer({ enabled = true })
    cmp_enabled = true
  end
end, {})
