-- assignment via API doesn't work at the moment
-- see https://github.com/neovim/neovim/issues/23522
local markdown = {
  extenstion = {
    md = "markdown",
  }
}
local hocon = {
  extenstion = {
    conf = "hocon",
  }
}
local avro = {
  extenstion = {
    avro = "json",
    avsc = "json"
  }
}

vim.filetype.add(avro)
vim.filetype.add(hocon)
vim.filetype.add(markdown)

-- so doing it old-style via autocommands
-- LSP/Java {
vim.api.nvim_create_autocmd(
  "BufReadPre",
  {
    group = "lsp-java",
    desc = "Assign 'java' filetype to a project file",
    pattern = {"pom.xml", "build.gradle"},
    command = "setlocal filetype=java"
  }
)
--
-- }
-- LSP/Terraform {
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufWinEnter"},
  {
    group = "lsp-terraform",
    desc = "Assign 'Terraform' filetype to .tf files",
    pattern = {"*.tf"},
    command = "setlocal filetype=terraform"
  }
)
-- }
-- LSP/misc {
vim.api.nvim_create_augroup("AdditionalFileTypes", {})
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufWinEnter"},
  {
    group = "AdditionalFileTypes",
    desc = "Assign 'JSON' filetype to Avro files",
    pattern = {"*.avro", "*.avsc"},
    command = "setlocal filetype=json"
  }
)
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufWinEnter"},
  {
    group = "AdditionalFileTypes",
    desc = "Assign 'HOCON' filetype to .conf files",
    pattern = {"*.conf"},
    command = "setlocal filetype=hocon"
  }
)
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufWinEnter"},
  {
    group = "AdditionalFileTypes",
    desc = "Assign 'Markdown' filetype to .md files",
    pattern = {"*.md"},
    command = "setlocal filetype=markdown shiftwidth=2"
  }
)
-- }
