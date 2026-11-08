import QtQuick
import Quickshell.Io
import Quickshell
import qs.components
import qs.theme
import qs.services

Pill {
    id: root

    clickable: true

    onClicked: Quickshell.execDetached(["kitty", "--class", "kitty_float", "--title", "Monitor del sistema", "-e", "btop"])

    tooltipText: "RAM: " + HardwareServices.ramUse.toFixed(1) + " / " + HardwareServices.ramTotal.toFixed(1) + " GB\nCPU: " + HardwareServices.cpu + "%\n" + "GPU:" + HardwareServices.gpuName

    Row {

        spacing: Sizes.gapItems
        
        PillText {
            text: " " + HardwareServices.ram + "%"
        }
    
        PillText {
            text: " " + HardwareServices.cpu + "%"
        }
    }    
}