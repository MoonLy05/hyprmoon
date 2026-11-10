pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real timeTurn: 0

    Process {
        id: countProc
        command: ["cat", "/proc/uptime"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const datos = this.text.trim().split(" ")
                root.timeTurn = parseFloat(datos[0])
            }
        }
    }

    Timer {
        interval: 60 * 1000
        running: true
        repeat: true
        onTriggered: countProc.running = true
    }

    readonly property string timeText: {
        if (timeTurn <= 0)
            return "calculando…"
        const h = Math.floor(timeTurn / 3600)
        const m = Math.floor((timeTurn % 3600) / 60)
        return h + " h " + m + " min"
    }
}