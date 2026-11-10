pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // 1. dos propiedades: la cantidad (int) y si No molestar está activo (bool)
    property bool molestarDnd: false
    property int numNotifications: 0

    Process {
        command: ["swaync-client", "-swb"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                const datos = JSON.parse(line)
                root.numNotifications = parseInt(datos.text) || 0
                root.molestarDnd = datos.alt.startsWith("dnd")
            }
        }
    }

    function alternateDnd(){
        Quickshell.execDetached(["swaync-client", "-d"])
    }
}