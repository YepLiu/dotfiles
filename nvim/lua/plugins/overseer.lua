---@type LazySpec
return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerToggle", "OverseerRun", "OverseerBuild" },
  keys = {
    { "<Leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle overseer task list" },
    { "<Leader>or", "<cmd>OverseerRun<cr>", desc = "List overseer run templates" },
  },
  opts = {
    dap = false,
    templates = { "make", "cargo", "shell", "user.run_python", "user.run_script" },
    task_list = {
      direction = "left",
      bindings = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    },
  },
  config = function(_, opts)
    local overseer = require "overseer"
    overseer.setup(opts)

    -- custom behavior of make templates
    overseer.add_template_hook({ module = "^make$" }, function(task_defn, util)
      util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
      util.add_component(task_defn, "on_complete_notify")
      util.add_component(task_defn, { "display_duration", detail_level = 1 })
    end)
  end,
}
