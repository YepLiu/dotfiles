return {
  -- 确保先装/加载 telescope 本体
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    -- 明确声明依赖，保证先加载 telescope 再 load_extension
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("fzf")
      end
    end,
  },
}
