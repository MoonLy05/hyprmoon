import QtQuick
import Quickshell
import qs.components
import qs.theme
import qs.services

Pill {
    id: root

    clickable: true
    onClicked: Quickshell.execDetached([KeyboardService.script])
    tooltipText: KeyboardService.layout + "\n" + (KeyboardService.capsLock ? "Mayúsculas activadas" : "Mayúsculas desactivadas")

    PillText { 
        text: "  " + KeyboardService.layoutLabel + (KeyboardService.capsLock ? " 󰘲" : "")
    }
}