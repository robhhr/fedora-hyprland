require("nvim-treesitter.configs").setup({
  -- To install additional languages, do: `:TSInstall <mylang>`. `:TSInstall maintained` to install all maintained
  ensure_installed = { "html", "css", "javascript", "json", "lua", "markdown", "php", "scss", "tsx" },
  sync_installed = true,
  highlight = {
   enable = true, -- This is a MUST
   additional_vim_regex_highlighting = { "php" },
  },
  indent = {
   enable = false, -- Really breaks stuff if true
  },
  incremental_selection = {
   enable = true,
   keymaps = {
    init_selection = "gnn",
    node_incremental = "grn",
    scope_incremental = "grc",
    node_decremental = "grm",
   },
  },
 })
