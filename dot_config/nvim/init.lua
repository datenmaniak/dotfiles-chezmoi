
-- Instalar Lazy si no existe
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2


require("core.options")
require("core.keymaps")
require("plugins.init")
-- require("plugins.lsp")
require("plugins.cmp")
require("plugins.formatter")
require("ui.lualine")
require("branding.banner")

-- {
--   -- "neovim/nvim-lspconfig",          -- LSP base
--   "williamboman/mason.nvim",        -- Instalador de servidores
--   "williamboman/mason-lspconfig.nvim",
--   "hrsh7th/nvim-cmp",               -- Autocompletado
--   "hrsh7th/cmp-nvim-lsp",
--   "L3MON4D3/LuaSnip",               -- Snippets
--   "saadparwaiz1/cmp_luasnip",
--   "nvimtools/none-ls.nvim",         -- Formateo/linting
--   "folke/trouble.nvim",             -- Diagnóstico visual
-- }
