return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { width = 0.9, height = 0.8 },
      sorting_strategy = "ascending",
      prompt_prefix = "🔍 ",
    },
  },
}
