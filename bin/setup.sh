#!/usr/bin/env bash
# Bind SUPER+L to the dwindle/monocle toggle on this machine.
# Hyprland keybindings live in Hyprland's config, not in the plugin, so the
# plugin ships this installer instead of binding itself.
set -eu

BINDINGS_LUA="${HOME}/.config/hypr/bindings.lua"
MARKER="xhcoding.tweaks/bin/toggle-workspace-layout"

if [[ -f "$BINDINGS_LUA" ]] && grep -qF "$MARKER" "$BINDINGS_LUA"; then
  echo "SUPER+L is already bound to the xhcoding.tweaks toggle in $BINDINGS_LUA"
  exit 0
fi

if [[ ! -d "$(dirname "$BINDINGS_LUA")" ]]; then
  echo "error: $(dirname "$BINDINGS_LUA") does not exist (is Hyprland configured?)" >&2
  exit 1
fi

mkdir -p "$(dirname "$BINDINGS_LUA")"
touch "$BINDINGS_LUA"
cat >>"$BINDINGS_LUA" <<'EOF'

-- xhcoding.tweaks: SUPER + L toggles the active workspace between
-- dwindle and monocle (replaces the default dwindle <-> scrolling toggle).
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Toggle dwindle/monocle layout", "~/.config/omarchy/plugins/xhcoding.tweaks/bin/toggle-workspace-layout monocle")
EOF

echo "Added the SUPER+L binding to $BINDINGS_LUA"
echo "Hyprland picks it up on the next config reload; if WIN+L does nothing, run: hyprctl reload"
