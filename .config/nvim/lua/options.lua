local options = {
  number = true,            -- show numbers
  background = 'dark',      -- bg
  hlsearch = true,          -- highlight search results
  tabstop = 2,              -- tab size
  shiftwidth = 0,           -- autoindent size
  smartindent = true,       -- set smart indents
  expandtab = true,         -- spaces
  swapfile = false,         -- no backup files
  mouse = "i",              -- enable mouse on insert
  showmatch = true,         -- highlights matching bracket
  termguicolors = true,     -- for themes
  hidden = true,            -- multiple buffers
  showmode = true,          -- add insert msg
  encoding = 'utf-8',       -- encoding
  cmdheight = 2,            -- better msg readability
  scrolloff = 8,            -- replace zz
  relativenumber = true    -- relative
}

for k, v in pairs(options) do
  vim.opt[k] = v
end