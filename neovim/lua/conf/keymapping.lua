-- vi:nospell
-- Global mappings {
---- Toggle custom variable(s)
vim.api.nvim_set_keymap("n", "<leader>e","", { noremap = true, silent = true, desc = "Togglee format on sav[e]", callback = function() vim.g.formatonsave = vim.g.formatonsave ~= true end })
---- Reuse arrows
vim.api.nvim_set_keymap("", "<Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
---- Swap : and ; to make colon commands easier to type
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = false, nowait = true })
vim.api.nvim_set_keymap("n", ":", ";", { noremap = true, silent = false, nowait = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true, silent = false, nowait = true })
vim.api.nvim_set_keymap("v", ":", ";", { noremap = true, silent = false, nowait = true })
---- Keep search matches in the middle of a window
vim.api.nvim_set_keymap("n", "n", "nzzzv", {})
vim.api.nvim_set_keymap("n", "N", "Nzzzv", {})
-- }
-- Remap indentation-aware pasting {
vim.api.nvim_set_keymap("n", "qp", "]p", { noremap = true, silent = false, nowait = true })
vim.api.nvim_set_keymap("n", "qP", "[p", { noremap = true, silent = false, nowait = true })
-- }
-- Spelling {
vim.api.nvim_set_keymap("n", "<leader>sn", "]s", { desc = "mis[s]pelled, [n]ext occurrence" })
vim.api.nvim_set_keymap("n", "<leader>sp", "[s", { desc = "mis[s]pelled, [p]revious occurrence"})
vim.api.nvim_set_keymap("n", "<leader>sr", ":spellr", { desc = "repeat replacement for all other occurrences" })
vim.api.nvim_set_keymap("n", "<leader>sg", "zg", { desc = "mark as correct spelling, adds to the user dictionary"} )
-- }
-- Plugin mappings {
-- -- Neo-tree {
vim.api.nvim_set_keymap("n", "<C-f>", ":Neotree position=float source=filesystem reveal=true toggle<CR>",  {noremap = true, silent = true} )
vim.api.nvim_set_keymap("n", "<C-g>", ":Neotree position=float source=git_status toggle<CR>", {noremap = true, silent = true} )
vim.api.nvim_set_keymap("n", "<C-b>", ":Neotree position=float source=buffers toggle<CR>", {noremap = true, silent = true} )
-- -- }
-- Telescope/generic {
vim.api.nvim_set_keymap("n", "<leader>f",   "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true, silent = true, desc = "find [f]iles"} )
vim.api.nvim_set_keymap("n", "<leader>fh",  "<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>", {noremap = true, silent = true, desc = "find [f]iles, include [h]idden"})
vim.api.nvim_set_keymap("n", "<leader>b",   "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap = true, silent = true, desc = "show [b]uffers"})
vim.api.nvim_set_keymap("n", "<leader>g",   "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true, silent = true, desc = "show [g]rep"})
vim.api.nvim_set_keymap("n", "<leader>q",   "<cmd>lua require('telescope.builtin').quickfix()<CR>", {noremap = true, silent = true, desc = "show [q]uickfix"})
vim.api.nvim_set_keymap("n", "<leader>y",   "<cmd>lua require('telescope.builtin').colorscheme()<CR>", {noremap = true, silent = true, desc = "pick a colorscheme for [y]ourself"})
vim.api.nvim_set_keymap("n", "<leader>s",   "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", { noremap = true, silent = true, desc = "spelling [s]uggestions list"})
-- }
-- Telescope/lsp {
vim.api.nvim_set_keymap("n", "<leader>ds",  "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", {noremap = true, silent = true, desc = "[d]ocument [s]ymbols"})
vim.api.nvim_set_keymap("n", "<leader>ws",  "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", {noremap = true, silent = true, desc = "[w]orkspace [s]ymbols"})
vim.api.nvim_set_keymap("n", "gD",          "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", {noremap = true, silent = true, desc = "[g]o to [D]efinitions"})
vim.api.nvim_set_keymap("n", "go",          "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>", {noremap = true, silent = true, desc = "[g]o to inc[o]ming calls"})
vim.api.nvim_set_keymap("n", "gO",          "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<CR>", {noremap = true, silent = true, desc = "[g]o to [O]utgoing calls"})
vim.api.nvim_set_keymap("n", "gr",          "<cmd>lua require('telescope.builtin').lsp_references()<CR>", {noremap = true, silent = true, desc = "[g]o to [r]eference"})
vim.api.nvim_set_keymap("n", "gi",          "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", {noremap = true, silent = true, desc = "[g]o to [i]mplementation"})
----
vim.api.nvim_set_keymap("n", "<leader>a",   "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: show [a]ll for this buffer"})
vim.api.nvim_set_keymap("n", "<leader>ae",  "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0, severity = 'error'})<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: show [a]ll [e]rrors for this buffer"})
vim.api.nvim_set_keymap("n", "<leader>aw",  "<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0, severity = 'warning'})<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: show [a]ll [w]arnings for this buffer"})
vim.api.nvim_set_keymap("n", "<leader>aa",  "<cmd>lua require('telescope.builtin').diagnostics()<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: [a]ll buffers, show [a]ll"})
vim.api.nvim_set_keymap("n", "<leader>aae", "<cmd>lua require('telescope.builtin').diagnostics({severity = 'error'})<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: [a]ll buffers, show [a]ll [e]rrors for this buffer"})
vim.api.nvim_set_keymap("n", "<leader>aaw", "<cmd>lua require('telescope.builtin').diagnostics({severity = 'warning'})<CR>", {noremap = true, silent = true, desc = "LSP diagnostics: [a]ll buffers, show [a]ll [w]arnings for this buffer"})
vim.api.nvim_set_keymap("n", "mc",          "<cmd>lua require('telescope').extensions.metals.commands()<CR>", {noremap = true, silent = true, desc = "[m]etals [c]ommands"})
-- }
-- LSP {
vim.api.nvim_set_keymap("n", "gd",          "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true, silent = true, desc = "[g]o to [d]efinition" })
vim.api.nvim_set_keymap("n", "K",           "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true, desc = "[K]. No, really, just K"})
vim.api.nvim_set_keymap("n", "<leader>rn",  "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true, silent = true, desc = "[r]e[n]ame"})
vim.api.nvim_set_keymap("n", "<leader>t",   "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", {noremap = true, silent = true, desc = "forma[t]"})
vim.api.nvim_set_keymap("n", "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true, silent = true, desc = "[c]ode [a]ctions"})
vim.api.nvim_set_keymap("n", "<leader>cl",  "<cmd>lua vim.lsp.codelens.run()<CR>", {noremap = true, silent = true, desc = "[c]ode [l]ense"})
-- }
-- Metals {
vim.api.nvim_set_keymap("n", "<leader>tv",  "<cmd>lua require('metals.tvp').toggle_tree_view()<CR>", {noremap = true, silent = true, desc = "[t]ree [v]iew"})
vim.api.nvim_set_keymap("n", "<leader>tr",  "<cmd>lua require('metals.tvp').reveal_in_tree()<CR>", {noremap = true, silent = true, desc = "[r]eveal in tree view"})
-- }
-- lsp_lines {
vim.api.nvim_set_keymap("n", "<leader>z",   "<cmd>lua require('lsp_lines').toggle()<CR>", {noremap = true, silent = true, desc = "toggle show/hide error[z] description"})
-- }
-- glow {
vim.api.nvim_set_keymap("n", "<C-l>", ":Glow<CR>", {noremap = true, silent = true})
-- }
-- }
