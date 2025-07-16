return {
  'hat0uma/csvview.nvim',
  commander = {
    {
      cmd = '<CMD>CsvViewToggle<CR>',
      desc = 'CsvView Toggle',
    },
  },
  opts = {
    parser = {
      comments = { '#', '//' },
    },
    view = {
      display_mode = 'border',
      spacing = 1,
      header_lnum = 1,
      sticky_header = {
        --- Whether to enable the sticky header feature
        --- @type boolean
        enabled = true,

        --- The separator character for the sticky header window
        --- set `false` to disable the separator
        --- @type string|false
        separator = '─',
      },
    },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { 'if', mode = { 'o', 'x' } },
      textobject_field_outer = { 'af', mode = { 'o', 'x' } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
      jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
      -- jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
      -- jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
    },
  },
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
}
