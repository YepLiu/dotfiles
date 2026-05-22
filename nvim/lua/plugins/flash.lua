-- Flash: 超快“跳转/选中/远程操作”插件
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = true }, -- 保留 f/F/t/T 增强
      },
    },
    keys = {
      { "s",  function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",  function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      { "r",  function() require("flash").remote() end,            mode = "o",               desc = "Flash remote (operator)" },
      { "R",  function() require("flash").treesitter_search() end, mode = { "n", "x", "o" }, desc = "Flash TS search" },
      { "<C-s>", function() require("flash").toggle() end,         mode = { "c" },           desc = "Toggle Flash in cmdline" },
    },
  },
}
