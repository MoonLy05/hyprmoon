pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    readonly property string script: Quickshell.env("HOME") + "/.config/hypr/scripts/kb_change.sh"
    
    property string layout: ""
    property bool capsLock: false
    readonly property string layoutLabel: {
        if (root.layout === "Spanish (Latin American)") 
            return "LA" 
        else if (root.layout === "English (US)") 
            return "US" 
        else
              return root.layout
    }

    Process {
        id: restoreLayout
        command: ["sh", "-c", "hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()
                root.layout = texto
            }
        }
    }

    Process {
        id: capsProc
        command: ["sh", "-c", "hyprctl devices -j | jq -r 'any(.keyboards[]; .capsLock)'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()
                root.capsLock = texto === "true"
            }
        }
    }

    Timer {
        interval: 300      
        running: true
        repeat: true
        onTriggered: {
            capsProc.running = true
        }
    }
    
    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                root.layout = event.data.split(',')[1]
            }
        }
    }
}