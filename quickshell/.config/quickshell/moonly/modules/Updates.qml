import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.theme
import qs.services

Pill {

    clickable: true
    id: root
    implicitWidth: Sizes.verticalPillWidth
    verticalPadding: Sizes.verticalPadding                     

    visible: UpdatesService.total > 0
    tooltipEdge: Edges.Right 

    tooltipText: "Paquetes Aur  = " + UpdatesService.aur + "\nPaquetes offical 󰣇 = " + UpdatesService.official

    Column {
        spacing: Sizes.gapText

        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "󰏗"
        }
        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: UpdatesService.total
            font.bold: true
        }
    }
}