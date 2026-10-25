# xhcoding.tweaks

Home for personal Omarchy customizations.

## Layout toggle (SUPER + L)

Toggles the active workspace between `dwindle` and `monocle`.

Hyprland keybindings live in Hyprland's config, not in the plugin, so
installing the plugin does not bind the key. On each machine, run the
installer once (idempotent — it appends the unbind + bind to
`~/.config/hypr/bindings.lua`):

```bash
omarchy plugin add https://github.com/xhcoding/xhcoding.tweaks --enable
~/.config/omarchy/plugins/xhcoding.tweaks/bin/setup.sh
```

If the key does nothing afterwards, run `hyprctl reload`.

- `bin/toggle-workspace-layout` — the toggle logic. Persists the per-workspace
  choice to `~/.local/state/omarchy/workspace-layouts/` (which the shipped
  `workspace-layouts.lua` loads on every Hyprland config reload) and sends a
  desktop notification with the result. Works standalone:

  ```bash
  ~/.config/omarchy/plugins/xhcoding.tweaks/bin/toggle-workspace-layout monocle
  ```

- `Service.qml` — headless service that tracks the active workspace's layout
  (polled every 5 s). Enable it with `omarchy plugin enable xhcoding.tweaks`
  (not required for the keybinding to work).
