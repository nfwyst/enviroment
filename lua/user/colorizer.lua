local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok or is_large_file then
  return
end

colorizer.setup(nil, {
  RRGGBBAA = true,
  rgb_fn = true,
})
