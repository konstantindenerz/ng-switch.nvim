local M = {}

local transforms = {
  component = {
    ts = ".component.ts",
    html = ".component.html",
    style = ".component.scss",
    spec = ".component.spec.ts",
    stories = ".component.stories.ts",
  },
  ng = {
    ts = ".ng.ts",
    html = ".ng.html",
    style = ".ng.scss",
    spec = ".spec.ng.ts",
    stories = ".stories.ng.ts",
  },
}

local function get_component_base(path)
  return path:match("^(.*)%.component%.")
end

local function get_ng_base(path)
  return path:match("^(.*)%.spec%.ng%..*$") or path:match("^(.*)%.stories%.ng%..*$") or path:match("^(.*)%.ng%..*$")
end

local function switch(target)
  local path = vim.fn.expand("%")
  local new_path

  if path:find("%.component%.") then
    local base = get_component_base(path)
    if base and transforms.component[target] then
      new_path = base .. transforms.component[target]
    end
  elseif path:find("%.ng%.") then
    local base = get_ng_base(path)
    if base and transforms.ng[target] then
      new_path = base .. transforms.ng[target]
    end
  end

  if new_path and new_path ~= path then
    vim.cmd.edit(new_path)
  end
end

M.to_ts = function()
  switch("ts")
end
M.to_html = function()
  switch("html")
end
M.to_style = function()
  switch("style")
end
M.to_spec = function()
  switch("spec")
end
M.to_stories = function()
  switch("stories")
end

function M.setup(opts)
  opts = opts or {}
  local cmds = { TS = M.to_ts, HTML = M.to_html, Style = M.to_style, Spec = M.to_spec, Stories = M.to_stories }
  for cmd, func in pairs(cmds) do
    vim.api.nvim_create_user_command("NgSwitch" .. cmd, func, {})
  end
  if opts.keymaps then
    for key, cmd in pairs({ t = "TS", h = "HTML", c = "Style", sp = "Spec", st = "Stories" }) do
      vim.keymap.set("n", "<leader>cn" .. key, ":NgSwitch" .. cmd .. "<cr>", { desc = "To " .. cmd })
    end
  end
end

return M
