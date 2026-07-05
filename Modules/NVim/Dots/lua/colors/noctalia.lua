vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ede0dd", bg = "#181211" })
hl("NormalFloat",  { fg = "#ede0dd", bg = "#181211" })
hl("Cursor",       { fg = "#181211", bg = "#ffb4a8" })

hl("CursorLine",   { bg = "#2f2827" })
hl("LineNr",       { fg = "#a08c89" })
hl("CursorLineNr", { fg = "#ffb4a8", bold = true })

hl("Comment",      { fg = "#a08c89", italic = true })
hl("Keyword",      { fg = "#ffb4a8", bold = true })
hl("Function",     { fg = "#ffb4a8" })
hl("String",       { fg = "#ede0dd" })
hl("Identifier",   { fg = "#ede0dd" })
hl("Constant",     { fg = "#e7bdb6" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#dec38c" })
hl("DiagnosticInfo",  { fg = "#ffb4a8" })
hl("DiagnosticHint",  { fg = "#ede0dd" })

hl("WinSeparator", { fg = "#ffb4a8" })
hl("Pmenu",        { fg = "#ede0dd", bg = "#251e1d" })
hl("PmenuSel",     { fg = "#181211", bg = "#ffb4a8" })
