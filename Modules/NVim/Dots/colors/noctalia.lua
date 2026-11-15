vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ece0d9", bg = "#17120f" })
hl("NormalFloat",  { fg = "#ece0d9", bg = "#17120f" })
hl("Cursor",       { fg = "#17120f", bg = "#ffb875" })

hl("CursorLine",   { bg = "#2f2925" })
hl("LineNr",       { fg = "#9e8e82" })
hl("CursorLineNr", { fg = "#ffb875", bold = true })

hl("Comment",      { fg = "#9e8e82", italic = true })
hl("Keyword",      { fg = "#ffb875", bold = true })
hl("Function",     { fg = "#ffb875" })
hl("String",       { fg = "#ece0d9" })
hl("Identifier",   { fg = "#ece0d9" })
hl("Constant",     { fg = "#e2c0a5" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#c2cc98" })
hl("DiagnosticInfo",  { fg = "#ffb875" })
hl("DiagnosticHint",  { fg = "#ece0d9" })

hl("WinSeparator", { fg = "#ffb875" })
hl("Pmenu",        { fg = "#ece0d9", bg = "#241f1a" })
hl("PmenuSel",     { fg = "#17120f", bg = "#ffb875" })
