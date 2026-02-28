require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "html", "cssls", "ts_ls", "phpactor", "pyright",
    "bashls", "zls", "jsonls", "yamlls", "lua_ls"
  }
})

local lspconfig = require("lspconfig")  -- aún válido para setup()

local servers = {
  "html", "cssls", "ts_ls", "phpactor", "pyright",
  "bashls", "zls", "jsonls", "yamlls", "lua_ls"
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end
