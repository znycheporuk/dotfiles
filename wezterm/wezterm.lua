local wezterm = require 'wezterm'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

local function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Catppuccin Mocha'
    else
        return 'Catppuccin Latte'
    end
end

return {
    color_scheme = scheme_for_appearance(get_appearance()),

    -- Other configurations
    font = wezterm.font("ComicShannsMono Nerd Font"),
    font_size = 16.0,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.8,
    macos_window_background_blur = 20,
    text_background_opacity = 1,
    window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    },
}
