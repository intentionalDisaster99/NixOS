vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "noctalia"

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal",       { fg = "#e0e3e0", bg = "#111413" })
hl("NormalFloat",  { fg = "#e0e3e0", bg = "#111413" })
hl("Cursor",       { fg = "#111413", bg = "#5adbc0" })

hl("CursorLine",   { bg = "#272b29" })
hl("LineNr",       { fg = "#89938f" })
hl("CursorLineNr", { fg = "#5adbc0", bold = true })

hl("Comment",      { fg = "#89938f", italic = true })
hl("Keyword",      { fg = "#5adbc0", bold = true })
hl("Function",     { fg = "#5adbc0" })
hl("String",       { fg = "#e0e3e0" })
hl("Identifier",   { fg = "#e0e3e0" })
hl("Constant",     { fg = "#b1ccc3" })

hl("DiagnosticError", { fg = "#ffb4ab" })
hl("DiagnosticWarn",  { fg = "#aacbe4" })
hl("DiagnosticInfo",  { fg = "#5adbc0" })
hl("DiagnosticHint",  { fg = "#e0e3e0" })

hl("WinSeparator", { fg = "#5adbc0" })
hl("Pmenu",        { fg = "#e0e3e0", bg = "#1d201f" })
hl("PmenuSel",     { fg = "#111413", bg = "#5adbc0" })
