-- plugins.lua
-- Configuración de plugins usando lazy.nvim
-- Este archivo carga toggleterm.nvim sin mapeos como F1/F2
-- Compatible con TerminalPicker PRO

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local ok, toggleterm = pcall(require, "toggleterm")
      if not ok then
        vim.notify("toggleterm.nvim no está instalado", vim.log.levels.ERROR)
        return
      end

      toggleterm.setup({
        direction = "float", -- Terminal flotante por defecto
        open_mapping = nil, -- No se asigna ninguna tecla como <leader>f1
        shade_terminals = true, -- Sombreado para mejor visibilidad
        start_in_insert = true, -- Iniciar en modo insert automáticamente
        persist_size = false, -- No guardar tamaño entre sesiones
      })
    end,
  },
}
