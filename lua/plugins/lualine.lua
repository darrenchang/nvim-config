-- Use gitsigns to keep track of git info
local function git_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  local added = gitsigns.added
  local modified = gitsigns.changed
  local removed = gitsigns.removed
  local git_info = {}
  if added > 0 then
    table.insert(git_info, '+' .. added)
  end
  if modified > 0 then
    table.insert(git_info, '~' .. modified)
  end
  if removed > 0 then
    table.insert(git_info, '-' .. removed)
  end
  if gitsigns then
    return table.concat(git_info, ' ')
  end
end
-- Get the window number
local function window()
  return vim.api.nvim_win_get_number(0)
end

-- Format functionfor displaying macro recording status
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

-- Returns a string with a list of attached LSP clients, including
-- formatters and linters from null-ls, nvim-lint and formatter.nvim
local function get_attached_clients()
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return 'LSP Inactive'
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= 'copilot' and client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  -- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.

  -- Add sources (from null-ls)
  -- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
  local null_ls_s, null_ls = pcall(require, 'null-ls')
  if null_ls_s then
    local sources = null_ls.get_sources()
    for _, source in ipairs(sources) do
      if source._validated then
        for ft_name, ft_active in pairs(source.filetypes) do
          if ft_name == buf_ft and ft_active then
            table.insert(buf_client_names, source.name)
          end
        end
      end
    end
  end

  -- Add linters (from nvim-lint)
  local lint_s, lint = pcall(require, 'lint')
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == 'table' then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == 'string' then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  -- Add formatters (from formatter.nvim)
  local formatter_s, _ = pcall(require, 'formatter')
  if formatter_s then
    local formatter_util = require('formatter.util')
    for _, formatter in
      ipairs(formatter_util.get_available_formatters_for_ft(buf_ft))
    do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end

  -- This needs to be a string only table so we can use concat below
  local unique_client_names = {}
  for _, client_name_target in ipairs(buf_client_names) do
    local is_duplicate = false
    for _, client_name_compare in ipairs(unique_client_names) do
      if client_name_target == client_name_compare then
        is_duplicate = true
      end
    end
    if not is_duplicate then
      table.insert(unique_client_names, client_name_target)
    end
  end

  local client_names_str = table.concat(unique_client_names, ', ')
  local language_servers = string.format('%s', client_names_str)

  return language_servers
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local attached_clients = {
        get_attached_clients,
        color = {},
      }
      require('lualine').setup({
        options = {
          theme = 'dracula',
          globalstatus = false,
          disabled_filetypes = { 'neo-tree' },
          ignore_focus = { 'neo-tree', 'lazy' },
          refresh = {
            statusline = 1000, -- Refresh every second (can be adjusted)
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              window,
            },
            {
              'filename',
            },
            {
              'macro-recording',
              fmt = show_macro_recording,
            },
          },
          lualine_b = {
            {
              git_diff,
            },
            {
              'diagnostics',
              update_in_insert = true,
            },
          },
          lualine_c = {
            {},
          },
          lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
            attached_clients,
            'progress',
          },
          lualine_y = {},
          lualine_z = {
            'location',
            'searchcount',
          },
        },
        inactive_sections = {
          lualine_a = {
            {
              window,
            },
            {
              'filename',
            },
            {
              git_diff,
            },
            {
              'diagnostics',
              update_in_insert = true,
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            'progress',
            'location',
          },
        },
      })
      -- Force refresh lualine as soon as entering recording state
      vim.api.nvim_create_autocmd('RecordingEnter', {
        callback = function()
          require('lualine').refresh({
            place = { 'statusline' },
          })
        end,
      })
      -- Refresh lualine after leaving recording state
      vim.api.nvim_create_autocmd('RecordingLeave', {
        callback = function()
          -- This is going to seem really weird!
          -- Instead of just calling refresh we need to wait a moment because of the nature of
          -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
          -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
          -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
          -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
          local timer = vim.loop.new_timer()
          timer:start(
            50,
            0,
            vim.schedule_wrap(function()
              require('lualine').refresh({
                place = { 'statusline' },
              })
            end)
          )
        end,
      })
    end,
  },
}
