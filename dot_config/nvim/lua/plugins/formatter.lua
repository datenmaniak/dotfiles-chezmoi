local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,   -- HTML, CSS, JS
    null_ls.builtins.formatting.stylua,     -- Lua
    null_ls.builtins.formatting.black,      -- Python
    null_ls.builtins.formatting.shfmt,      -- Bash/Zsh
    null_ls.builtins.formatting.phpcsfixer, -- PHP
  },
})
