local borders = require("ah.plugins.telescope.borders")

local function merge(left, right)
	return vim.tbl_deep_extend("force", left or {}, right or {})
end

local function create_prompt(picker, overrides)
	local Popup = require("nui.popup")
	return Popup(merge({
		enter = true,
		border = {
			style = "single",
			text = {
				top = picker.prompt_title,
				top_align = "center",
			},
		},
		win_options = { winhighlight = "Normal:Normal" },
	}, overrides))
end

local function create_results(picker, overrides)
	local Popup = require("nui.popup")
	return Popup(merge({
		focusable = false,
		border = {
			style = "single",
			text = {
				top = picker.results_title,
				top_align = "center",
			},
		},
		win_options = { winhighlight = "Normal:Normal" },
	}, overrides))
end

local function create_preview(picker, overrides)
	local Popup = require("nui.popup")
	return Popup(merge({
		focusable = false,
		border = {
			style = "single",
			text = {
				top = picker.preview_title,
				top_align = "center",
			},
		},
		win_options = { winhighlight = "Normal:Normal" },
	}, overrides))
end

local function create_picker_window(popup)
	function popup.border:change_title(title)
		popup.border.set_text(popup.border, "top", title)
	end
	return require("telescope.pickers.layout").Window(popup)
end

local function create_picker_layout(picker, layout, parts)
	layout.picker = picker
	if parts.results then
		layout.results = create_picker_window(parts.results)
	end
	if parts.prompt then
		layout.prompt = create_picker_window(parts.prompt)
	end
	if parts.preview then
		layout.preview = create_picker_window(parts.preview)
	end
	return layout
end

local M = {}

M.default = function(picker)
	local Layout = require("nui.layout")

	local layout_config = merge({
		relative = "editor",
		position = "50%",
		size = "80%",
	}, picker.layout_config)

	if not picker.previewer then
		return M.vertical(picker)
	end

	local parts = nil
	local box = nil

	if picker.sorting_strategy == "ascending" then
		parts = {
			prompt = create_prompt(picker, { border = { style = borders.double.top_left_box } }),
			results = create_results(
				picker,
				{ border = { style = borders.double.bottom_left_box } }
			),
			preview = create_preview(picker, { border = { style = borders.double.right_box } }),
		}
		box = Layout.Box({
			Layout.Box({
				Layout.Box(parts.prompt, { size = 2 }),
				Layout.Box(parts.results, { grow = 1 }),
			}, { dir = "col", size = "40%" }),
			Layout.Box(parts.preview, { size = "60%" }),
		}, { dir = "row" })
	else
		parts = {
			results = create_results(picker, { border = { style = borders.double.top_left_box } }),
			prompt = create_prompt(picker, { border = { style = borders.double.bottom_left_box } }),
			preview = create_preview(picker, { border = { style = borders.double.right_box } }),
		}
		box = Layout.Box({
			Layout.Box({
				Layout.Box(parts.results, { grow = 1 }),
				Layout.Box(parts.prompt, { size = 2 }),
			}, { dir = "col", size = "40%" }),
			Layout.Box(parts.preview, { size = "60%" }),
		}, { dir = "row" })
	end

	return create_picker_layout(picker, Layout(layout_config, box), parts)
end

M.vertical = function(picker)
	local Layout = require("nui.layout")

	local parts = nil
	local box = nil

	if picker.previewer and picker.sorting_strategy == "ascending" then
		parts = {
			prompt = create_prompt(picker, { border = { style = borders.single.top_box } }),
			results = create_results(picker, { border = { style = borders.single.middle_box } }),
			preview = create_preview(picker, { border = { style = borders.single.bottom_box } }),
		}
		box = Layout.Box({
			Layout.Box(parts.prompt, { size = 2 }),
			Layout.Box(parts.results, { grow = 1 }),
			Layout.Box(parts.preview, { grow = 1 }),
		}, { dir = "col" })
	elseif picker.previewer and picker.sorting_strategy == "descending" then
		parts = {
			results = create_results(picker, { border = { style = borders.single.top_box } }),
			prompt = create_prompt(picker, { border = { style = borders.single.middle_box } }),
			preview = create_preview(picker, { border = { style = borders.single.bottom_box } }),
		}
		box = Layout.Box({
			Layout.Box(parts.results, { grow = 1 }),
			Layout.Box(parts.prompt, { size = 2 }),
			Layout.Box(parts.preview, { grow = 1 }),
		}, { dir = "col" })
	elseif not picker.previewer and picker.sorting_strategy == "ascending" then
		parts = {
			prompt = create_prompt(picker, { border = { style = borders.single.top_box } }),
			results = create_results(picker, { border = { style = borders.single.bottom_box } }),
		}
		box = Layout.Box({
			Layout.Box(parts.prompt, { size = 2 }),
			Layout.Box(parts.results, { grow = 1 }),
		}, { dir = "col" })
	elseif not picker.previewer and picker.sorting_strategy == "descending" then
		parts = {
			results = create_results(picker, { border = { style = borders.single.top_box } }),
			prompt = create_prompt(picker, { border = { style = borders.single.bottom_box } }),
		}
		box = Layout.Box({
			Layout.Box(parts.results, { grow = 1 }),
			Layout.Box(parts.prompt, { size = 2 }),
		}, { dir = "col" })
	end

	local layout_config = merge({
		relative = "editor",
		position = "50%",
		size = "90%",
	}, picker.layout_config)

	return create_picker_layout(picker, Layout(layout_config, box), parts)
end

M.window = function(picker)
	local Layout = require("nui.layout")
	local Popup = require("nui.popup")

	local box = nil

	local parts = {
		prompt = Popup({ enter = true, win_options = { winhighlight = "Normal:Normal" } }),
		results = Popup({ focusable = false, win_options = { winhighlight = "Normal:Normal" } }),
	}

	if picker.sorting_strategy == "ascending" then
		box = Layout.Box({
			Layout.Box(parts.prompt, { size = 1 }),
			Layout.Box(parts.results, { grow = 1 }),
		}, { dir = "col" })
	else
		box = Layout.Box({
			Layout.Box(parts.results, { grow = 1 }),
			Layout.Box(parts.prompt, { size = 1 }),
		}, { dir = "col" })
	end

	local layout_config = merge({
		position = 0,
		size = "100%",
	}, picker.layout_config)

	return create_picker_layout(picker, Layout(layout_config, box), parts)
end

return M
