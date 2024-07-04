-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.term = "xterm-256color"
-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"

config.animation_fps = 60
config.max_fps = 60
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.font_size = 20
config.line_height = 1.1

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { italic = true })
-- config.font = wezterm.font("FiraCode Nerd Font Mono", { italic = true })
config.harfbuzz_features = {
	"calt",
	"liga",
	"ss01",
	"ss02",
	"ss04",
	"ss05",
	"ss06",
	"ss07",
	"ss08",
	"ss10",
	"ss11",
	"ss12",
	"ss17",
	"ss18",
}

config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false

config.window_padding = {
	top = 20,
	left = 20,
	right = 20,
	bottom = 5,
}
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.65,
}
config.force_reverse_video_cursor = true

config.default_cursor_style = "BlinkingBar"
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- key bindings
config.keys = {
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- close tab
	{ key = "w", mods = "SUPER|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
	-- close pane
	{ key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = false }) },
}
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

local mux = wezterm.mux
wezterm.on("gui-attached", function(domain)
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

return config
