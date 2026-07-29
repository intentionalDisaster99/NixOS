vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ede0de", bg = "#181211" })
hl("NormalFloat",  { fg = "#ede0de", bg = "#181211" })
hl("Cursor",       { fg = "#181211", bg = "#ffb4a9" })

hl("CursorLine",   { bg = "#2f2827" })
hl("LineNr",       { fg = "#a08c89" })
hl("CursorLineNr", { fg = "#ffb4a9", bold = true })

hl("Comment",      { fg = "#a08c89", italic = true })
hl("Keyword",      { fg = "#ffb4a9", bold = true })
hl("Function",     { fg = "#ffb4a9" })
hl("String",       { fg = "#ede0de" })
hl("Identifier",   { fg = "#ede0de" })
hl("Constant",     { fg = "#e7bdb7" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#dfc38c" })
hl("DiagnosticInfo",  { fg = "#ffb4a9" })
hl("DiagnosticHint",  { fg = "#ede0de" })

hl("WinSeparator", { fg = "#ffb4a9" })
hl("Pmenu",        { fg = "#ede0de", bg = "#251e1d" })
hl("PmenuSel",     { fg = "#181211", bg = "#ffb4a9" })
