local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"
    local location = nil
    local type = '__default' or '__multiline'
    local cursor_location = require('ts_context_commentstring.utils').get_cursor_location()
    local visual_start_location = require('ts_context_commentstring.utils').get_visual_start_location()

    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
        if ctx.ctype == U.ctype.blockwise then
            location = cursor_location
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = visual_start_location
        end

        return require('ts_context_commentstring.internal').calculate_commentstring({
            key = ctx.ctype == U.ctype.linewise and type,
            location = location,
        })
    end

    if ctx.ctype == U.ctype.block then
      location = cursor_location
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = visual_start_location
    end

    return require("ts_context_commentstring.internal").calculate_commentstring({
      key = ctx.ctype == U.ctype.line and type,
      location = location,
    })
  end,
}

