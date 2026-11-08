pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    
    property string weather: ""
    property string temperature: ""
    property string location: ""
    property string sensation: ""
    property string humidity: ""
    property string wind: ""
    
    Process {
        id: weatherProc
        command: ["curl", "-s", "wttr.in/?format=%t|%C|%f|%h|%w|%l&m"]
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
                root.sensation = partes[2].replace("+", "")
                root.humidity = partes[3]
                root.wind = partes[4]
                root.location = partes[5]
            }
        }
    }

    Timer {
        interval: 30 * 60 * 1000
        running: true
        repeat: true
        onTriggered: weatherProc.running = true
    }
    
}