local present, gitsigns = pcall(require, "gitsigns")
if not present then
  return
end
gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  current_line_blame = true,
  on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
    require("user.modules.whichkey").registers {
      g = {
        name = "Git",
        j = { gs.next_hunk, "Next Hunk" },
        k = { gs.prev_hunk, "Prev Hunk" },
        l = { gs.blame_line, "Blame" },
        p = { gs.preview_hunk, "Preview Hunk" },
        r = { gs.reset_hunk, "Reset Hunk" },
        R = { gs.reset_buffer, "Reset Buffer" },
        s = { gs.stage_hunk, "Stage Hunk" },
        u = { gs.undo_stage_hunk, "Undo Stage Hunk" },
        d = { ":Gitsigns diffthis HEAD<cr>", "Git Diff" },
      }, {
				buffer = bufnr
			}
    }
  end,
}
