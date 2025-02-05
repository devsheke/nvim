local M = {}

M.ensure_installed = {
    "bash",
    "c",
    "css",
    "diff",
    "dockerfile",
    "gitcommit",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "nix",
    "norg",
    "python",
    "rust",
    "sql",
    "svelte",
    "templ",
    "toml",
    "typescript",
    "yaml",
    "zig",
}

M.highlight = {
    enable = true,
    use_languagetree = true,
}

M.indent = { enable = true }

return M
