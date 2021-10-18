local f = require("api.functions")
local map = f.map

local nr = { noremap = true }
local slnr = { silent = true, noremap = true }

-- NERDTree {
map("n", "<C-g>", ":NERDTreeToggle<CR>", nr)
-- }
-- glow {
map("n", "<C-l>", ":Glow<CR>", nr)
-- }
-- LSP {
map("n", "gd",          "<cmd>lua vim.lsp.buf.definition()<CR>", slnr)
map("n", "gi",          "<cmd>lua vim.lsp.buf.implementation()<CR>", slnr)
map("n", "gr",          "<cmd>lua vim.lsp.buf.references()<CR>", slnr)
map("n", "K",           "<cmd>lua vim.lsp.buf.hover()<CR>", slnr)
map("n", "sh",          "<cmd>lua vim.lsp.buf.signature_help()<CR>", slnr)
map("n", "<leader>rn",  "<cmd>lua vim.lsp.buf.rename()<CR>", slnr)
map("n", "<leader>t",   "<cmd>lua vim.lsp.buf.formatting()<CR>", slnr)
map("n", "<leader>cl",  "<cmd>lua vim.lsp.codelens.run()<CR>", slnr)
-- }
-- metals {
map("n", "<leader>a",   "<cmd>lua require('metals').open_all_diagnostics()<CR>", slnr)
map("n", "<leader>tv",  "<cmd>lua require('metals.tvp').toggle_tree_view()<CR>", slnr)
map("n", "<leader>tr",  "<cmd>lua require('metals.tvp').reveal_in_tree()<CR>", slnr)
-- }
-- telescope {
map("n", "gds",         "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", slnr)
map("n", "gws",         "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", slnr)
map("n", "<leader>ca",  "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", slnr)
map("n", "<leader>f",   "<cmd>lua require('telescope.builtin').find_files()<CR>", slnr)
map("n", "<leader>fh",  "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", slnr)
map("n", "<leader>fb",  "<cmd>lua require('telescope.builtin').buffers()<CR>", slnr)
map("n", "<leader>fg",  "<cmd>lua require('telescope.builtin').live_grep()<CR>", slnr)
map("n", "<leader>fq",  "<cmd>lua require('telescope.builtin').quickfix()<CR>", slnr)
map("n", "mc",          "<cmd>lua require('telescope').extensions.metals.commands()<CR>", slnr)
-- }
