vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#ece0df", bg = "#181212" })
hl("NormalFloat",  { fg = "#ece0df", bg = "#181212" })
hl("Cursor",       { fg = "#181212", bg = "#ffb3b4" })

hl("CursorLine",   { bg = "#2f2828" })
hl("LineNr",       { fg = "#a08c8c" })
hl("CursorLineNr", { fg = "#ffb3b4", bold = true })

hl("Comment",      { fg = "#a08c8c", italic = true })
hl("Keyword",      { fg = "#ffb3b4", bold = true })
hl("Function",     { fg = "#ffb3b4" })
hl("String",       { fg = "#ece0df" })
hl("Identifier",   { fg = "#ece0df" })
hl("Constant",     { fg = "#e6bdbc" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#e5c18d" })
hl("DiagnosticInfo",  { fg = "#ffb3b4" })
hl("DiagnosticHint",  { fg = "#ece0df" })

hl("WinSeparator", { fg = "#ffb3b4" })
hl("Pmenu",        { fg = "#ece0df", bg = "#241e1e" })
hl("PmenuSel",     { fg = "#181212", bg = "#ffb3b4" })
