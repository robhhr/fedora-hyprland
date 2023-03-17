local options = {
  background = 'dark',      -- bg
  cmdheight = 2,            -- better msg readability
  encoding = 'utf-8',       -- encoding
  expandtab = true,         -- spaces
  foldcolumn = '1',
  foldexpr = 'nvim_treesitter#foldexpr()',
  foldlevel = 99,            -- dont fold everything by default
  foldmethod = 'indent',
  guifont = "monospace:h17",
  hidden = true,            -- multiple buffers
  hlsearch = true,          -- highlight search results
  linebreak = true,
  mouse = "i",              -- enable mouse on insert
  nofoldenable,
  number = true,            -- show numbers
  numberwidth = 4,          -- number column width
  relativenumber = true,    -- relative
  scrolloff = 8,            -- replace zz
  shiftwidth = 0,           -- autoindent size
  showmatch = true,         -- highlights matching bracket
  showmode = true,          -- add insert msg
  sidescrolloff = 4,        -- horizontal view
  smartindent = true,       -- set smart indents
  smarttab = true,
  splitright = false,       -- force Y-splits to go below active
  swapfile = false,         -- no backup files
  tabstop = 2,              -- tab size
  termguicolors = true,     -- for themes
  textwidth = 0,
  timeoutlen = 200,         -- faster completion
  undofile = true,          -- enable persistent undo
  updatetime = 100,         -- faster completion
  wildignore = "*node_modules/**",
  wrap = true,              -- text wrap
  wrapmargin = 0,
}

for i, j in pairs(options) do
  vim.opt[i] = j
end
