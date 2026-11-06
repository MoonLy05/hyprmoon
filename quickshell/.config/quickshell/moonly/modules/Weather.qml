import QtQuick
import Quickshell.Io
import qs.components
import qs.theme

Pill {
    id: root

    property string weather: ""
    property string temperature: ""

    Process {
        id: weatherProc
        command: ["curl", "-s", "wttr.in/?format=%t|%C&m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()

                // Sin internet, curl no trae el "|": no tocamos nada
                if (!texto.includes("|"))
                    return

                const partes = texto.split("|")
                root.temperature = partes[0].replace("+", "")
                root.weather = partes[1]
            }
        }
    }

    Timer {
        interval: 30 * 60 * 1000
        running: true
        repeat: true
        onTriggered: weatherProc.running = true
    }

    Row {
        spacing: 6

        PillText {
            text: root.temperature
            font.pixelSize: Fonts.small
            font.bold: true
        }

        PillText {
            text: root.weather
            font.pixelSize: Fonts.small
            opacity: 0.7
        }
    }
}