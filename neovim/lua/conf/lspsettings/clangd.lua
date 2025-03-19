local util = require 'lspconfig.util'

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local clangd_settings = {
  default_config = {
    cmd = {
      'clangd',
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--import-insertions",
      "-j4",
      "--fallback-style=llvm",
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_dir = function(fname)
      return util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'configure',
        'CMakeLists.txt',
        'CMakePresets.json',
        'Makefile'
        )(fname) or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    single_file_support = true,
    capabilities = {
      textDocument = { completion = { editsNearCursor = true, }, },
      offsetEncoding = { 'utf-8', 'utf-16' },
    },
  },
  commands = {},
  docs = {
    description = 'See https://clangd.llvm.org/installation.html',
  },
}
return { clangd_settings }
