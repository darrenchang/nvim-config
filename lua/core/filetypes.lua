vim.filetype.add({
  pattern = {
    ["Dockerfile.*"] = "dockerfile",
    ["requirements.*.txt"] = "config",
  },
})
