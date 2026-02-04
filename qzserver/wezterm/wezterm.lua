local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.use_ime = true

-- 1. 核心修复 (解决 Protocol Error)
-- ---------------------------------------------------------
-- 强制禁用 Wayland 协议，使用 XWayland (X11) 运行
-- 这是目前 NVIDIA 显卡在 Wayland 下最稳的方案
config.enable_wayland = false

-- 2. 外观配置
-- ---------------------------------------------------------
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 13.0
config.window_background_opacity = 0.98
config.window_decorations = "RESIZE"
-- 重点：让背景更加平滑
config.text_background_opacity = 1.0

-- 光标样式：使用漂亮的垂直条，并开启闪烁
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600


wezterm.on('update-status', function(window, pane)
    -- 获取当前的日期/时间
    local date = wezterm.strftime('%Y-%m-%d %H:%M:%S')

    -- 组合成一段美观的文字
    window:set_right_status(wezterm.format({
        { Foreground = { Color = '#89b4fa' } }, -- 蓝色
        { Text = '  ' .. date .. ' ' },
        { Foreground = { Color = '#f5c2e7' } }, -- 粉色
        { Text = ' 󰣇 CachyOS ' },
    }))
end)

-- 标签栏视觉优化 (极简风格)
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true -- 只有一个标签时自动隐藏，省空间
config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = '#89b4fa', -- Catppuccin Blue
            fg_color = '#1e1e2e',
        },
        inactive_tab = {
            bg_color = '#313244',
            fg_color = '#cdd6f4',
        }
    }
}

-- 3. 生产力配置
-- ---------------------------------------------------------
config.default_cwd = "home"
config.enable_scroll_bar = false
config.keys = {
    { key = 'V', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'F11', mods = 'NONE', action = wezterm.action.ToggleFullScreen },
    -- 1. 分屏 (Panes)
    -- Alt + D 垂直分屏 (左右)
    { key = 'd', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Alt + Shift + D 水平分屏 (上下)
    { key = 'D', mods = 'ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    -- Alt + W 关闭当前窗格
    { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },

    -- 2. 切换窗格 (Navigation)
    -- 使用 Alt + 方向键 在窗格间跳跃
    { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

    -- 3. 标签页管理 (Tabs)
    -- Alt + T 新建标签页
    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    -- Alt + [1-9] 直接切换到对应标签页
    { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
}


-- 让标签栏更美观一点
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true -- 标签栏放在底部，更有极客感


return config
