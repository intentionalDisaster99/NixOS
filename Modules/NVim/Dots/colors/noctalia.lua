vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e2e2e5", bg = "#121416" })
hl("NormalFloat",  { fg = "#e2e2e5", bg = "#121416" })
hl("Cursor",       { fg = "#121416", bg = "#98cbff" })

hl("CursorLine",   { bg = "#282a2d" })
hl("LineNr",       { fg = "#8c9199" })
hl("CursorLineNr", { fg = "#98cbff", bold = true })

hl("Comment",      { fg = "#8c9199", italic = true })
hl("Keyword",      { fg = "#98cbff", bold = true })
hl("Function",     { fg = "#98cbff" })
hl("String",       { fg = "#e2e2e5" })
hl("Identifier",   { fg = "#e2e2e5" })
hl("Constant",     { fg = "#b9c8da" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#d4bee6" })
hl("DiagnosticInfo",  { fg = "#98cbff" })
hl("DiagnosticHint",  { fg = "#e2e2e5" })

hl("WinSeparator", { fg = "#98cbff" })
hl("Pmenu",        { fg = "#e2e2e5", bg = "#1e2022" })
hl("PmenuSel",     { fg = "#121416", bg = "#98cbff" })
