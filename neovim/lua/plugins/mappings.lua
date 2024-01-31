local f = require("api.functions")
local map = f.map

-- Neo-tree {
map("n", "<C-g>", ":Neotree toggle<CR>")
-- }
-- glow {
map("n", "<C-l>", ":Glow<CR>")
-- }
-- LSP {
map("n", "gd",          "<cmd>lua vim.lsp.buf.definition()<CR>", "[g]o to [d]efinition" )
map("n", "gD",          "<cmd>lua vim.lsp.buf.declaration()<CR>", "[g]o to [D]eclaration")
map("n", "gi",          "<cmd>lua vim.lsp.buf.implementation()<CR>", "[g]o to [i]mplementation")
map("n", "gr",          "<cmd>lua vim.lsp.buf.references()<CR>", "[g]o to [r]eference")
map("n", "go",          "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "[g]o to inc[o]ming calls")
map("n", "gO",          "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "[g]o to [O]utgoing calls")
map("n", "K",           "<cmd>lua vim.lsp.buf.hover()<CR>", "[K]. No, really, just K")
map("n", "sh",          "<cmd>lua vim.lsp.buf.signature_help()<CR>", "[s]ignature [h]elp")
map("n", "<leader>rn",  "<cmd>lua vim.lsp.buf.rename()<CR>", "[r]e[n]ame")
map("n", "<leader>t",   "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "forma[t]")
map("n", "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<CR>", "[c]ode [a]ctions")
map("n", "<leader>cl",  "<cmd>lua vim.lsp.codelens.run()<CR>", "[c]ode [l]ense")
-- }
-- metals {
map("n", "<leader>a",   "<cmd>lua require('metals').open_all_diagnostics()<CR>", "[a]ll diagnostics")
map("n", "<leader>tv",  "<cmd>lua require('metals.tvp').toggle_tree_view()<CR>", "[t]ree [v]iew")
map("n", "<leader>tr",  "<cmd>lua require('metals.tvp').reveal_in_tree()<CR>", "[r]eveal in tree view")
-- }
-- telescope {
map("n", "<leader>ds",  "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "[d]ocument [s]ymbols")
map("n", "<leader>ws",  "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", "[w]orkspace [s]ymbols")
map("n", "<leader>f",   "<cmd>lua require('telescope.builtin').find_files()<CR>", "find [f]iles")
map("n", "<leader>fh",  "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", "find [f]iles, include [h]idden")
map("n", "<leader>b",   "<cmd>lua require('telescope.builtin').buffers()<CR>", "show [b]uffers")
map("n", "<leader>g",   "<cmd>lua require('telescope.builtin').live_grep()<CR>", "show [g]rep")
map("n", "<leader>q",   "<cmd>lua require('telescope.builtin').quickfix()<CR>", "show [q]uickfix")
map("n", "mc",          "<cmd>lua require('telescope').extensions.metals.commands()<CR>", "[m]etals [c]ommands")
-- }
-- lsp_lines {
map("n", "<leader>z",   "<cmd>lua require('lsp_lines').toggle()<CR>", "toggle show/hide error[z] description")
-- }
-- UFO {
map("n", "zR",   "<cmd>lua require('ufo').openAllFolds()<CR>")
map("n", "zM",   "<cmd>lua require('ufo').closeAllFolds()<CR>")
-- }
