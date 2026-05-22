return {
  name = "run script",
  condition = {
    filetype = { "sh", "python" },
  },
  params = {
    args = { optional = true, type = "list", delimiter = " " },
  },
  builder = function(params)
    local file = vim.fn.expand "%:p"
    local cwd = vim.fn.expand "%:p:h"
    local ft = vim.bo.filetype

    -- 1. 自动检测 shebang（如果有就优先用）
    local first_line = vim.fn.getline(1)
    local cmd

    if first_line:match "^#!" then
      -- 提取 shebang interpreter（例如 "/usr/bin/env python"）
      cmd = first_line:gsub("^#!%s*", ""):gsub("\r", "")
    else
      -- 没写 shebang 就按文件类型决定
      if ft == "sh" then
        cmd = "sh"
      else
        cmd = "python3"
      end
    end

    return {
      name = vim.fn.fnamemodify(file, ":t"),
      cmd = cmd,
      cwd = cwd,
      args = vim.list_extend({ file }, params.args or {}),
      components = {
        "task_list_on_start",
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
        "on_output_summarize",
      },
    }
  end,
}
