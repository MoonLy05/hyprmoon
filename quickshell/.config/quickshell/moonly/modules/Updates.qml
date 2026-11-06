import QtQuick
import Quickshell
import Quickshell.Io
import qs.components
import qs.theme

Pill {

    clickable: true
    id: root
    implicitWidth: Sizes.verticalPillWidth
    verticalPadding: Sizes.verticalPadding                     

    readonly property string script: Quickshell.env("HOME") + "/.config/quickshell/moonly/scripts/updates.sh"

    property int official: 0
    property int aur: 0
    readonly property int total: official + aur

    visible: total > 0
    tooltipEdge: Edges.Right 

    tooltipText: "Paquetes Aur  = " + aur + "\nPaquetes offical 󰣇 = " + official

    Process {
        id: countProc
        command: [root.script, "count"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const partes = this.text.trim().split(" ")
                root.official = parseInt(partes[0]) || 0
                root.aur = parseInt(partes[1]) || 0
            }
        }
    }

    Timer {
        interval: 30 * 60 * 1000
        running: true
        repeat: true
        onTriggered: countProc.running = true
    }

    Process {
        id: updateProc
        command: [root.script, "update"]   // cambia "update" por la palabra que use tu script para actualizar
        onExited: countProc.running = true // cuando kitty se cierra, vuelve a contar
    }
    
    onClicked: updateProc.running = true

    Column {
        spacing: 2

        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "󰏗"
        }
        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.total
            font.bold: true
        }
    }
}