---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local astrocore = require "astrocore"

    -- 1. 安全地往 ensure_installed 里加 parser（不覆盖 AstroNvim 默认配置）
    opts.ensure_installed = astrocore.list_insert_unique(opts.ensure_installed or {}, {
      "lua",
      "vim",
      "python",
      "bash",
      "json",
      "markdown",
      -- 你想要的别的语言也可以继续加，比如：
      -- "cpp",
      -- "rust",
      -- "go",
    })

    -- 2. 开启 textobjects（选择 + 跳转）
    opts.textobjects = opts.textobjects or {}

    -- ②-1 选择类文本对象（vaf/vif/vac/vic/vai/vii 等）
    opts.textobjects.select =
      vim.tbl_deep_extend("force", {
        enable = true,
        lookahead = true, -- 光标自动跳到下一个对象，体验更像 IDE
        keymaps = {
          -- 函数
          ["af"] = "@function.outer", -- a function：整个函数
          ["if"] = "@function.inner", -- inner function：函数体

          -- 类 / 结构体
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- 条件语句（if / switch...）
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",

          -- 循环（for / while）
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",

          -- 参数 / 参数列表
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
        },
      }, opts.textobjects.select or {})

    -- ②-2 在函数 / 类之间跳转（]m / [m / ]] / [[）
    opts.textobjects.move =
      vim.tbl_deep_extend("force", {
        enable = true,
        set_jumps = true, -- 记录到 jumplist，<C-o> 可以跳回来
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      }, opts.textobjects.move or {})

    return opts
  end,
}
