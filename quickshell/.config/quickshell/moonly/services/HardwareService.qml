pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string script: Quickshell.env("HOME") + "/.config/quickshell/moonly/scripts/gpu.sh"

    property int totalMem: 0
    property int availableMem: 0
    property int ram: 0
    property int cpu: 0
    readonly property real ramUse: (totalMem - availableMem) / 1024 / 1024
    readonly property real ramTotal: totalMem / 1024 / 1024
    property real prevTotal: 0
    property real prevIdle: 0

    property string gpuName: ""
    property int gpuVram: 0

    property string storageModel: ""
    property string storageSizeUse: ""
    property string storageSizeMax: ""
    property string storageSizePercentage: ""

    Process {
        id: storageModelProc
        command: ["lsblk", "-dno", "MODEL", "/dev/nvme0n1"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()
            
                root.storageModel = texto
            }
        }
    }

    Process {
        id: storageSizeProc
        command: ["sh", "-c", "df -h --output=used,size,pcent / | tail -1"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()
            
                const partes = texto.split(/\s+/)
                root.storageSizeUse = partes[0]
                root.storageSizeMax = partes[1]
                root.storageSizePercentage = partes[2]
            }
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: storageSizeProc.running = true
    }

    Process {
        id: gpuProc
        command: [root.script]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const texto = this.text.trim()
            
                if (!texto.includes("|"))
                    return
            
                const partes = texto.split("|")
                root.gpuName = partes[0].replace("NVIDIA GeForce ", "").replace("Laptop GPU","").trim()
                root.gpuVram = parseInt(partes[1]) || 0
            }
        }
    }
    
    Process {
        id: memProc
        command: ["cat", "/proc/meminfo"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                // 1. Parte this.text en 
                const lines = this.text.split("\n")

                // 2. Recorre los renglones y encuentra los dos que necesitas
                for (const line of lines) {
                    if (line.startsWith("MemTotal")) {
                        const partes = line.split(/\s+/)
                        root.totalMem = parseInt(partes[1])
                    } else if (line.startsWith("MemAvailable")) {
                        const partes = line.split(/\s+/)
                        root.availableMem = parseInt(partes[1])
                    }
                }
                // 3. Saca el número de cada uno
                const usedMem = root.totalMem - root.availableMem
                
                // 4. Calcula el porcentaje y guárdalo en root.ram
                
                root.ram = Math.round((usedMem / root.totalMem) * 100)
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
}