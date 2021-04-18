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
map("n", "gds",         "<cmd>lua vim.lsp.buf.document_symbol()<CR>", slnr)
map("n", "gws",         "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", slnr)
map("n", "<leader>f",   "<cmd>lua vim.lsp.buf.formatting()<CR>", slnr)
map("n", "<space>d",    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", slnr)
map("n", "[c",          "<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>", slnr)
map("n", "]c",          "<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>", slnr)
-- }
-- metals {
map("n", "<leader>a",   "<cmd>lua require'metals'.open_all_diagnostics()<CR>", slnr)
map("n", "<leader>ws",  "<cmd>lua require'metals'.workshiit_hover()<CR>", slnr)
-- }
-- lspsage {
map("n", "K",           "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", slnr)
map("n", "<S-Down>",    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", slnr)
map("n", "<S-Up>",      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", slnr)
map("n", "<leader>ca",  "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", slnr)
map("v", "<leader>ca",  ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", slnr)
map("n", "<leader>rn",  "<cmd>lua require('lspsaga.rename').rename()<CR>", slnr)
-- }
