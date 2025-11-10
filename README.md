# 💤 LazyVim with custom tools - @lumusitech

## 🧠 TerminalPicker - Uso y Atajos Internos

La herramienta `:TerminalPicker` permite gestionar terminales flotantes dentro de Neovim. A continuación se detallan los atajos disponibles **dentro de la interfaz** de TerminalPicker y el comportamiento esperado:

### 📋 Atajos dentro de TerminalPicker

| Atajo de Teclado | Acción                                       | Notas importantes                                                            |
| ---------------- | -------------------------------------------- | ---------------------------------------------------------------------------- |
| `Ctrl + d`       | Elimina la terminal seleccionada de la lista | No cierra la terminal si está abierta, solo la elimina del registro          |
| `Ctrl + s`       | Envía un comando a la terminal seleccionada  | Se abre un cuadro de diálogo en modo **normal**, presionar `i` para escribir |

### 🧱 Comportamiento de las terminales flotantes

- **Abrir terminal**: Al seleccionar una terminal desde la lista, se abre en modo **normal**.  
  → Presionar `i` para entrar en modo terminal y comenzar a interactuar.

- **Cerrar terminal**:  
  → Presionar `Esc` para salir del modo terminal.  
  → Luego ejecutar `:q` para cerrar la ventana flotante.

- **Reabrir terminal**:  
  → Se abrirá nuevamente en modo **normal**, por lo que es necesario presionar `i` para volver al modo terminal.

---

> ⚠️ **Importante:** Los atajos como `<leader>tt`, `<leader>tn`, etc., están reservados por LazyVim y pueden entrar en conflicto con otros plugins. Actualmente, la forma recomendada de iniciar TerminalPicker es mediante el comando `:TerminalPicker`.
> TODO: Buscar atajo de teclado disponible para abrir más rápido la herramienta.
