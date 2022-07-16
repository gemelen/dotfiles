local f = require("api.functions")
local map = f.map
local opt = f.opt

-- Global mappings {
opt("o", "pastetoggle", "<F3>")

map("c", "Q", "q!", { silent = false })
-- `command! W w !sudo tee % > /dev/null`
---- Reuse arrows
map("", "<Up>", ":resize +2<CR>", { noremap = true, silent = true })
map("", "<Down>", ":resize -2<CR>", { noremap = true, silent = true })
map("", "<Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
map("", "<Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
---- Swap : and ; to make colon commands easier to type
map("n", ";", ":", { noremap = true, silent = false, nowait = true })
map("n", ":", ";", { noremap = true, silent = false, nowait = true })
map("v", ";", ":", { noremap = true, silent = false, nowait = true })
map("v", ":", ";", { noremap = true, silent = false, nowait = true })
---- Keep search matches in the middle of a window
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- }
-- Remap indentation-aware pasting {
map("n", "qp", "]p", { noremap = true, silent = false, nowait = true })
map("n", "qP", "[p", { noremap = true, silent = false, nowait = true })
-- }
