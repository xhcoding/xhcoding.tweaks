# xhcoding.tweaks

Home for personal Omarchy customizations.

## Layout toggle (SUPER + L)

Toggles the active workspace between `dwindle` and `monocle`.

- `bin/toggle-workspace-layout` — the toggle logic. Bound to SUPER+L in
  `~/.config/hypr/bindings.lua`. Persists the per-workspace choice to
  `~/.local/state/omarchy/workspace-layouts/` (which the shipped
  `workspace-layouts.lua` loads on every Hyprland config reload) and sends
  a desktop notification with the result.
- `Service.qml` — headless service that tracks the active workspace's
  layout (polled every 5 s) and can toggle via IPC:

  ```bash
  omarchy-shell shell call xhcoding.tweaks toggle
  ```
