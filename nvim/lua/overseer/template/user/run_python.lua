return {
  name = "run python script",
  params = {
    cmd = { optional = true, type = "string", default = "python3" },
    cwd = { optional = true, type = "string" }, -- 可选：自定义工作目录
  },
  builder = function(params)
    local file = vim.fn.expand "%:p"
    local cwd = params.cwd or vim.fn.expand "%:p:h"

    return {
      name = vim.fn.fnamemodify(file, ":t"), -- 比如 "train.py"
      cmd = params.cmd,
      args = { file },
      cwd = cwd,
      components = {
        "task_list_on_start",
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
        "on_output_summarize",
        -- 你要的话可以再加：
        -- { "on_output_quickfix", open = false },
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
