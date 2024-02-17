local function readFile(filePath)
---@diagnostic disable-next-line: param-type-mismatch
  local file = io.open(filePath, "r")

  if not file then
    return nil
  end

---@diagnostic disable-next-line: undefined-field
  local contents = file:read("*all")

---@diagnostic disable-next-line: undefined-field
  file:close()

  return contents;
end -- readFile

local function read_nearest_ts_config(fromFile)
  local lsp = require('lspconfig')
  local rootDir = lsp.util.root_pattern('tsconfig.json')(fromFile);

  if not rootDir then
    return nil
  end

  local tsConfig = rootDir .. "/tsconfig.json"
  local contents = readFile(tsConfig)

  if not contents then
    return nil
  end

  local isGlint = string.find(contents, '"glint"')

  return {
    isGlint = not not isGlint,
    rootDir = rootDir,
  };
end -- read_nearest_ts_config

local function is_ts_project(filename)
  local result = read_nearest_ts_config(filename)

  if not result then
    return nil
  end

  if (result.isGlint) then
    return nil
  end

  return result.rootDir
end -- is_ts_project

local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local conditional_features = function (client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
    end
end

local tsserver_settings = { settings = {
  tsserver = {
    single_file_support = false,
    root_dir = is_ts_project,
    capabilities = capabilities,
    settings = {
        maxTsServerMemory = 8000,
        implicitProjectConfig = {
          experimentalDecorators = true
        },
      },
    on_attach = function(client, bufnr)
      conditional_features(client, bufnr)
    end
  }
}}

return { tsserver_settings }
