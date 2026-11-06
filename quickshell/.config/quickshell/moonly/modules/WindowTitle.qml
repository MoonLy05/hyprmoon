import QtQuick
import Quickshell.Hyprland
import qs.components
import qs.theme

Pill {
    id: root

    readonly property var win: Hyprland.activeToplevel

    readonly property bool hasWindow: win !== null
                                      && win.workspace !== null
                                      && win.workspace.id === Hyprland.focusedWorkspace.id

    readonly property string rawId: hasWindow && win.wayland !== null ? win.wayland.appId : ""

    readonly property string appName: rawId === "" ? "Escritorio Vacio" : shortId.slice(0, 1).toUpperCase() + shortId.slice(1)

    readonly property string shortId: {
        const partes = rawId.split(".")
        const ultimo = partes[partes.length - 1]
        return ultimo.split(/[-_]/)[0]
    }
    
    PillText {
        text: appName
    }
}