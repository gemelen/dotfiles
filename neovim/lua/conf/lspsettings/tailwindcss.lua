local tailwindcss_settings = { settings = {
  tailwindCSS = {
      includeLanguages = {
        markdown = "html",
        handlebars = "html",
        javascript = {
          glimmer = "javascript"
        },
        typescript = {
          glimmer = "javascript"
        }
      }
    }
}}

return { tailwindcss_settings }
