-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

vim.g.python3_host_prog = "/home/lumusitech/.venvs/nvim/bin/python"

-- Activar spell checker y configurar idiomas
vim.opt.spell = true
vim.opt.spelllang = { "en", "es" }

-- Definir archivo para palabras personalizadas
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.add"

require("config.terminal-picker")

require("config.toggleterm-setup")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
