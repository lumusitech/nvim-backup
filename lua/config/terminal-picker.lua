local function open_terminal_picker()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope no está cargado todavía", vim.log.levels.WARN)
    return
  end

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local Terminal = require("toggleterm.terminal").Terminal
  local get_all = require("toggleterm.terminal").get_all

  local function build_terminal_list()
    local terminals = {}
    local active = get_all()
    local max_id = 0

    for _, term in pairs(active) do
      max_id = math.max(max_id, term.id)
      local pid = term.job_id or "?"
      local shell = term.cmd and table.concat(term.cmd, " ") or "shell"
      table.insert(terminals, {
        name = string.format("Terminal %d [🟢 Abierta] 🗑️ - PID: %s - Shell: %s", term.id, pid, shell),
        count = term.id,
        open = true,
        pid = pid,
        shell = shell,
      })
    end

    table.insert(terminals, {
      name = "➕ Nueva Terminal",
      count = max_id + 1,
      new = true,
    })

    return terminals
  end

  local function show_picker()
    pickers
      .new({}, {
        prompt_title = "Gestionar Terminales",
        finder = finders.new_table({
          results = build_terminal_list(),
          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.name,
              ordinal = entry.name,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          -- Abrir o crear terminal
          map("i", "<CR>", function()
            local selection = action_state.get_selected_entry().value
            actions.close(prompt_bufnr)

            if selection.new then
              Terminal:new({ count = selection.count, direction = "float" }):toggle()
              vim.defer_fn(function()
                show_picker()
              end, 300)
              vim.notify("Nueva terminal creada (#" .. selection.count .. ")", vim.log.levels.INFO)
            else
              Terminal:new({ count = selection.count, direction = "float" }):toggle()
              vim.defer_fn(function()
                vim.cmd("startinsert")
              end, 100)
            end
          end)

          -- Cerrar terminal
          map("i", "<C-d>", function()
            local selection = action_state.get_selected_entry().value
            actions.close(prompt_bufnr)
            if selection.open then
              local active = get_all()
              for _, term in pairs(active) do
                if term.id == selection.count then
                  local bufnr = term.bufnr
                  if bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
                    vim.api.nvim_buf_delete(bufnr, { force = true })
                    vim.notify("Terminal " .. selection.count .. " cerrada", vim.log.levels.INFO)
                    vim.defer_fn(function()
                      show_picker()
                    end, 300)
                  else
                    vim.notify("No se encontró el buffer de la terminal", vim.log.levels.WARN)
                  end
                  return
                end
              end
              vim.notify("No se encontró la terminal activa", vim.log.levels.WARN)
            else
              vim.notify("La terminal ya está cerrada", vim.log.levels.INFO)
            end
          end)

          -- Enviar comando a terminal y cerrar
          map("i", "<C-s>", function()
            local selection = action_state.get_selected_entry().value
            actions.close(prompt_bufnr)

            if selection.open then
              vim.ui.input({ prompt = "Comando a enviar: " }, function(cmd)
                if cmd and #cmd > 0 then
                  local active = get_all()
                  for _, term in pairs(active) do
                    if term.id == selection.count then
                      term:send(cmd .. "\n")
                      local bufnr = term.bufnr
                      if bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
                      end
                      term:toggle()
                      vim.notify("Comando enviado a Terminal " .. selection.count, vim.log.levels.INFO)
                      vim.defer_fn(function()
                        show_picker()
                      end, 300)
                      return
                    end
                  end
                else
                  vim.notify("Comando vacío", vim.log.levels.WARN)
                end
              end)
            else
              vim.notify("La terminal está cerrada", vim.log.levels.WARN)
            end
          end)

          return true
        end,
      })
      :find()
  end

  show_picker()
end

vim.api.nvim_create_user_command("TerminalPicker", open_terminal_picker, {})
vim.keymap.set("n", "<leader>T", ":TerminalPicker<CR>", { desc = "Gestionar Terminales" })
