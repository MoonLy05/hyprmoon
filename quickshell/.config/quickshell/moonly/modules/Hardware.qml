import QtQuick
import Quickshell
import qs.components
import qs.theme
import qs.services

Pill {
    id: root

    clickable: true

    onClicked: Quickshell.execDetached(["kitty", "--class", "kitty_float", "--title", "Monitor del sistema", "-e", "btop"])

    tooltipText: "RAM: " + HardwareService.ramUse.toFixed(1) + " / " + HardwareService.ramTotal.toFixed(1) + " GB\nCPU: " + HardwareService.cpu + "%\n" + "GPU: " + HardwareService.gpuName + "\nM.2: " + HardwareService.storageModel + "\nStorage: " + HardwareService.storageSizeUse + " / " + HardwareService.storageSizeMax + " (" + HardwareService.storageSizePercentage + ")"

    Row {

        spacing: Sizes.gapItems
        
        PillText {
            text: " " + HardwareService.ram + "%"
        }
    
        PillText {
            text: " " + HardwareService.cpu + "%"
        }
    }    
}