local M = {}

-- ┌────────────┐
-- │ box        │
-- └────────────┘
M.box = {
	top = "─",
	bottom = "─",
	top_left = "┌",
	left = "│",
	bottom_left = "└",
	top_right = "┐",
	right = "│",
	bottom_right = "┘",
}

-- Single column layout
-- ┌────────────┐
-- │ top_box    │
-- ├────────────┤
-- │ middle_box │
-- ├────────────┤
-- │ bottom_box │
-- └────────────┘
M.single = {}

-- ┌──────────┐
-- │          │
M.single.top_box = merge(M.box, {
	bottom_left = "",
	bottom = "",
	bottom_right = "",
})

-- ├──────────┤
-- │          │
M.single.middle_box = merge(M.single.top_box, {
	top_left = "├",
	top_right = "┤",
})

-- ├──────────┤
-- │          │
-- └──────────┘
M.single.bottom_box = merge(M.box, {
	top_left = "├",
	top_right = "┤",
})

-- Double column layout
-- ┌─────────────────┬──────────────────┐
-- │ top_left_box    │                  │
-- ├─────────────────┤  right_box       │
-- │ bottom_left_box │                  │
-- └─────────────────┴──────────────────┘
-- ┌─────────────────┬──────────────────┐
-- │                 │ top_right_box    │
-- │ left_box        ├──────────────────┤
-- │                 │ bottom_right_box │
-- └─────────────────┴──────────────────┘
M.double = {}

-- ┌──────────┬
-- │          │
M.double.top_left_box = merge(M.single.top_box, {
	top_right = "┬",
})

-- ├──────────┤
-- │          │
-- └──────────┴
M.double.bottom_left_box = merge(M.single.bottom_box, {
	bottom_right = "┴",
})

-- ────────────┐
--             │
-- ────────────┘
M.double.right_box = merge(M.box, {
	top_left = "",
	left = "",
	bottom_left = "",
})

-- ┌────────────
-- │
-- └────────────
M.double.left_box = merge(M.box, {
	top_right = "",
	right = "",
	bottom_right = "",
})

-- ┬──────────┐
-- │          │
M.double.top_right_box = merge(M.single.top_box, {
	top_left = "┬",
})

-- ├──────────┤
-- │          │
-- ┴──────────┘
M.double.bottom_right_box = merge(M.single.bottom_box, {
	bottom_left = "┴",
})

return M
