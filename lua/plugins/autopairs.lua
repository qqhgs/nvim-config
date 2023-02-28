return {
  "windwp/nvim-autopairs",
  event = "VeryLazy",
  opts = {
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    map_c_h = true,
    map_c_w = true,
    fast_wrap = {
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    },
  },
}
