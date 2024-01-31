local api = vim.api

local function opt(scope, key, value)
  local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

local function map(mode, lhs, rhs, dsc)
  local options = { noremap = true, silent = true, desc = dsc }
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function mapopts(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

return {
  opt = opt,
  map = map,
  mapopts = mapopts,
}
