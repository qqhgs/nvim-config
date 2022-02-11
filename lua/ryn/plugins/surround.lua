local ready, surround = pcall(require, "surround")
if not ready then
	return
end

surround.setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", '"'},
  brackets = {"(", '{', '['},
  pairs = {
    nestable = {{"(", ")"}, {"[", "]"}, {"{", "}"}},
    linear = {{"'", "'"}, {"`", "`"}, {'"', '"'}}
  },
  prefix = "s"
}
