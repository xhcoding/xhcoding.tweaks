import QtQuick
import Quickshell
import Quickshell.Io

// Headless service that tracks the active workspace's tiled layout and can
// toggle it between dwindle and monocle. The toggle logic lives in
// bin/toggle-workspace-layout (also bound to SUPER+L in hypr/bindings.lua),
// so the keybinding and IPC share one implementation.
Item {
  id: root

  property var shell: null
  property var manifest: null

  // Tiled layout of the active workspace: "dwindle", "monocle", ...
  property string layout: ""

  readonly property string scriptPath:
    Qt.resolvedUrl("bin/toggle-workspace-layout").toString().replace("file://", "")

  function refresh() {
    if (queryProcess.running) return
    queryProcess.command = ["hyprctl", "-j", "activeworkspace"]
    queryProcess.running = true
  }

  function toggle() {
    if (toggleProcess.running) return
    toggleProcess.command = ["bash", scriptPath]
    toggleProcess.running = true
  }

  Process {
    id: queryProcess
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          root.layout = JSON.parse(text).tiledLayout || ""
        } catch (error) {
          root.layout = ""
        }
      }
    }
  }

  Process {
    id: toggleProcess
    onExited: root.refresh()
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
}
