local keymap = vim.keymap

-- File explorer
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

-- LSP
keymap.set("n", "gd", vim.lsp.buf.definition)
keymap.set("n", "K", vim.lsp.buf.hover)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
