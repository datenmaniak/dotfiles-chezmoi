return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  ft = { "markdown" },
  config = function()
    -- auto‑start al entrar en un Markdown
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_refresh_slow = 0 -- actualiza en vivo, sin esperar a guardar
  end,
}

