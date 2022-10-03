local status_ok, outline = pcall(require, "symbols-outline")
if not status_ok then
  return
end

outline.setup({
  position = 'left',
})
