pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int official: 0
    property int aur: 0
    readonly property int total: official + aur
    
    readonly property string script: Quickshell.env("HOME") + "/.config/quickshell/moonly/scripts/updates.sh"

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
        command: [root.script, "update"]
        onExited: countProc.running = true 
    }

    function actualizar() {
        updateProc.running = true
    }
}