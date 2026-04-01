-- ~/.config/nvim/lua/plugins/peek.lua (ejemplo)
vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
vim.api.nvim_create_user_command("PeekToggle", require("peek").toggle, {})

