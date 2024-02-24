local avro = { extension = { avro = "json", avsc = "json" } }
local hocon = { extension = { conf = "hocon", } }
local java = { filename = {
    ["pom.xml"] = "java",
    ["build.gradle"] = "java",
  }
}
local markdown = { extension = { md = "markdown", } }
local terraform = { extension = { tf = "terraform", } }

vim.filetype.add(avro)
vim.filetype.add(hocon)
vim.filetype.add(java)
vim.filetype.add(markdown)
vim.filetype.add(terraform)
