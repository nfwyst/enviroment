local status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not status_ok then
	return
end

tabnine:setup({
	max_lines = 1000,
	max_num_results = 3,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	show_prediction_strength = false,
})
