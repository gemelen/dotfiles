local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyopts = {
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  change_detection = { notify = false },
  rocks = { enabled = false, },
  performance = {
      rtp = {
          disabled_plugins = {
              'netrwPlugin',
              'rplugin',
              'tohtml',
              'tutor',
          },
      },
  },
}
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", lazyopts)
