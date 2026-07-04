require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "codebook", "cpptools", "nixfmt", "nixpkgs-fmt", "rust-analyzer", "snyk" }

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
