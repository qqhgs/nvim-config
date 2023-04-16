return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  keys = {
    { "<leader>h", desc = "Harpoon" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Add file" },
    {
      "<leader>hq",
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Quick menu",
    },
    { "<leader>hp", function() require("harpoon.ui").nav_prev() end, desc = "Prev" },
    { "<leader>hn", function() require("harpoon.ui").nav_next() end, desc = "Next" },
  },
}
