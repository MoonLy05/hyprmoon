import QtQuick
import Quickshell.Io
import qs.components
import qs.theme

Pill {
    id: root

    // ¿readonly o no?
    property int ram: 0
    property int cpu: 0
    property real prevTotal: 0
    property real prevIdle: 0

    Process {
        id: memProc
        command: ["cat", "/proc/meminfo"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                // 1. Parte this.text en 
                const lines = this.text.split("\n")

                let totalMem = 0
                let availableMem = 0

                // 2. Recorre los renglones y encuentra los dos que necesitas
                for (const line of lines) {
                    if (line.startsWith("MemTotal")) {
                        const partes = line.split(/\s+/)
                        totalMem = parseInt(partes[1])
                    } else if (line.startsWith("MemAvailable")) {
                        const partes = line.split(/\s+/)
                        availableMem = parseInt(partes[1])
                    }
                }
                // 3. Saca el número de cada uno
                const usedMem = totalMem - availableMem
                
                // 4. Calcula el porcentaje y guárdalo en root.ram
                
                root.ram = Math.round((usedMem / totalMem) * 100)
            }
        }
    }

    Process {
        id: cpuProc
        command: ["head", "-1", "/proc/stat"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n")

                const partes = lines[0].split(/\s+/)

                let total = 0

                for (let i = 1; i < partes.length; i++) {
                    total += parseInt(partes[i])
                }

                const idle = parseInt(partes[4]) + parseInt(partes[5])
                const difTotal = total - root.prevTotal
                const difIdle = idle - root.prevIdle

                if (root.prevTotal > 0) {
                    const difTrabajo = difTotal - difIdle
                    root.cpu = Math.round(difTrabajo / difTotal * 100)
                }

                root.prevTotal = total
                root.prevIdle = idle
            }
        }
    }

    // Timer aquí
    Timer {
        interval: 3000        
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true
            cpuProc.running = true
        }
    }

    Row {

        spacing: 10
        
        PillText {
            text: " " + root.ram + "%"
        }
    
        PillText {
            text: " " + root.cpu + "%"
        }
    }    
}