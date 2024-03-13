local function isYankAvailable()
    local handle = io.popen("which yank 2> /dev/null") -- Redirect stderr to avoid potential command line error messages
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result and result ~= "" -- Check if result is not nil and not empty
    else
        return false -- Handle is nil, indicating that 'io.popen' failed to execute
    end
end

local function yank(text)
    if not isYankAvailable() then
        print("Error: 'yank' command not found. Please install it from https://github.com/sunaku/home/blob/master/bin/yank")
        return
    end
    text = text:gsub('"', '\\"') -- Escape double quotes in the text to be yanked
    os.execute('echo "' .. text .. '" | yank')
end

_G.copyYank = function()
    local text = vim.fn.getreg('"') -- Get the content of the unnamed register as a string
    yank(text)
end

vim.api.nvim_set_keymap('n', '<Leader>y', 'y:lua _G.copyYank()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>y', 'y:lua _G.copyYank()<CR>', { noremap = true, silent = true })

