local map = vim.keymap.set
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorar directorios" })
map("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Terminal integrada" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Buscar archivos" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Buscar texto" })
