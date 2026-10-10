vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ece0da", bg = "#18120f" })
hl("NormalFloat",  { fg = "#ece0da", bg = "#18120f" })
hl("Cursor",       { fg = "#18120f", bg = "#ffb785" })

hl("CursorLine",   { bg = "#2f2925" })
hl("LineNr",       { fg = "#9f8d83" })
hl("CursorLineNr", { fg = "#ffb785", bold = true })

hl("Comment",      { fg = "#9f8d83", italic = true })
hl("Keyword",      { fg = "#ffb785", bold = true })
hl("Function",     { fg = "#ffb785" })
hl("String",       { fg = "#ece0da" })
hl("Identifier",   { fg = "#ece0da" })
hl("Constant",     { fg = "#e4bfa8" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#c8ca94" })
hl("DiagnosticInfo",  { fg = "#ffb785" })
hl("DiagnosticHint",  { fg = "#ece0da" })

hl("WinSeparator", { fg = "#ffb785" })
hl("Pmenu",        { fg = "#ece0da", bg = "#241e1b" })
hl("PmenuSel",     { fg = "#18120f", bg = "#ffb785" })
