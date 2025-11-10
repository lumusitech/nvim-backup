local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  vim.notify("toggleterm.nvim no está instalado", vim.log.levels.ERROR)
  return
end

toggleterm.setup({
  direction = "float",
  open_mapping = nil, -- no se asigna ninguna tecla como <leader>f1
  shade_terminals = true,
  start_in_insert = true,
  persist_size = false,
})
