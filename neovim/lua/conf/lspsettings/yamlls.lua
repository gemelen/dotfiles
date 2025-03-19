local yamlls_settings = require("yaml-companion").setup(
{
  validate = true,
  hover = true,
  completion = true,
  schemaStore = { enable = true, },
  builtin_matchers = { kubernetes = { enabled = true }, },
  filetypes = {"yaml"},
  schemas = {
    [ 'https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
    [ 'https://json.schemastore.org/github-action' ] = '.github/**/action.{yml,yaml}',
    [ 'kubernetes' ] = '*.k8s.yaml',
    [ 'https://cmake.org/cmake/help/latest/_downloads/3e2d73bff478d88a7de0de736ba5e361/schema.json' ] = 'CMakePresets.json',

-- Kubernetes files detection is broken for me, the only way to force LSP for a file is to use modeline, pointing to a specific kind
-- # yaml-language-server: $schema=https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.2-standalone-strict/pod.json

-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.2-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.2-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.6-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.9-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.7-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.11-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.26.14-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.16-standalone-strict/all.json"
-- "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.24.17-standalone-strict/all.json"
  }
})
return { yamlls_settings }
