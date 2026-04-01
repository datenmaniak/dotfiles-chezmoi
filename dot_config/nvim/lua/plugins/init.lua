-- Ruta de instalación de Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Instalar Lazy.nvim si no existe
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end

-- ✅ Agregar Lazy al runtimepath (¡no lo elimines!)
vim.opt.rtp:prepend(lazypath)

-- Cargar plugins
require("lazy").setup({

  -- Peek
  {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  ft = { "markdown" },
  config = function()
    require("peek").setup({
      auto_load = true,        -- abre el preview al entrar en Markdown
      close_on_bdelete = true, -- cierra el preview si se borra el buffer
      syntax = true,           -- sintaxis/color en el preview
      theme = "dark",          -- o "light"
      update_on_change = true, -- actualiza al escribir
      throttle_at = 200000,    -- empieza a regularizar si el fichero es muy grande
      throttle_time = "auto",
      filetype = { "markdown" },
    })
  end,
},


  -- ================== Markdown ==================
  {
    "iamcco/markdown-preview.nvim",
    -- build = function()
    --   vim.fn["mkdp#util#install"]()
    --end,
    --
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
    config = function()
      -- Se abre automático al entrar en un Markdown
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0  -- actualiza en vivo
    end,
  },

  -- Explorador de archivos
  { "nvim-tree/nvim-tree.lua" },

  -- Terminal integrada
  { "akinsho/toggleterm.nvim" },

  -- Barra de estado visual
  { "nvim-lualine/lualine.nvim" },

  -- Búsqueda fuzzy
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Iconos para archivos
  { "nvim-tree/nvim-web-devicons" },

  -- Gestor de LSP y herramientas
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -- Autocompletado
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Formateo y linting
  { "nvimtools/none-ls.nvim" },

  -- Diagnóstico visual
  { "folke/trouble.nvim" },

  -- Atajos interactivos
  { "folke/which-key.nvim", config = true },
  -- Monokai 
  {
    "cpea2506/one_monokai.nvim",
    priority = 1000,  -- Carga primero
    lazy = false,     -- Carga inmediatamente
    config = function()
      vim.opt.termguicolors = true
      require("one_monokai").setup()
      vim.cmd("colorscheme one_monokai")
    end,
  },
})





