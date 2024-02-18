local yamlls_settings = require("yaml-companion").setup({
    builtin_matchers = {
    kubernetes = { enabled = true },
    cloud_init = { enabled = false }
  },
  schemas = {
    { name = "Kubernetes 1.29.2", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.2-standalone-strict/all.json" },
    { name = "Kubernetes 1.28.7", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.7-standalone-strict/all.json" },
    { name = "Kubernetes 1.27.11", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.11-standalone-strict/all.json" },
    { name = "Kubernetes 1.26.14", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.26.14-standalone-strict/all.json" },
    { name = "Kubernetes 1.25.16", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.16-standalone-strict/all.json" },
    { name = "Kubernetes 1.24.17", url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.24.17-standalone-strict/all.json" },
  }
})
return { yamlls_settings }
