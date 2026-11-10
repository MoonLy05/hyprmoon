import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.components
import qs.theme

Pill {
    id: root

    // ─── Datos: bocinas (salida) ───
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool speakerMuted: sink && sink.audio.muted
    readonly property int speakerVolume: sink ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool speakerOff: speakerMuted || speakerVolume === 0

    // ─── Datos: micrófono (entrada) ───
    readonly property var source: Pipewire.defaultAudioSource
    readonly property bool micMuted: source && source.audio.muted
    readonly property int micVolume: source ? Math.round(source.audio.volume * 100) : 0
    readonly property bool micOff: micMuted || micVolume === 0

    // PipeWire solo manda datos de los objetos que alguien vigila
    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    // ─── Íconos según el estado ───
    readonly property string speakerIcon: {
        if (speakerOff)
            return "󰝟"
        else if (speakerVolume <= 30)
            return "󰕿"
        else if (speakerVolume <= 70)
            return "󰖀"
        else
            return "󰕾"
    }

    readonly property string micIcon: micOff ? "󰍭" : "󰍬"

    // ─── Apariencia de la pastilla ───
    implicitWidth: Sizes.verticalPillWidth
    verticalPadding: Sizes.verticalPadding
    tooltipEdge: Edges.Right
    tooltipText: sink && source
                 ? "Salida: " + sink.description + "\nEntrada: " + source.description
                 : ""

    // ─── Acciones ───
    function alternarMute(destino) {
        destino.audio.muted = !destino.audio.muted
    }

    function cambiarVolumen(destino, wheel) {
        const paso = 0.05
        const level = destino.audio.volume / paso
        const target = wheel.angleDelta.y > 0
            ? Math.floor(level + 0.001) + 1
            : Math.ceil(level - 0.001) - 1
        destino.audio.volume = Math.max(0, Math.min(1, target * paso))
    }

    // ─── Contenido: mic arriba, bocinas abajo ───
    Column {
        spacing: Sizes.gapItems

        VerticalText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: micOff ? micIcon : micIcon + " " + micVolume + "%"
            fontSize: Fonts.small
            color: micOff ? ColorsMatugen.inactive : ColorsMatugen.textOnSurface

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton)
                        Quickshell.execDetached(["pavucontrol", "--tab=4"])
                    else
                        root.alternarMute(root.source)
                }
                onWheel: (wheel) => root.cambiarVolumen(root.source, wheel)
            }
        }

        VerticalText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: speakerOff ? speakerIcon : speakerIcon + " " + speakerVolume + "%"
            fontSize: Fonts.small
            color: speakerOff ? ColorsMatugen.inactive : ColorsMatugen.textOnSurface

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton)
                        Quickshell.execDetached(["pavucontrol", "--tab=3"])
                    else
                        root.alternarMute(root.sink)
                }
                onWheel: (wheel) => root.cambiarVolumen(root.sink, wheel)
            }
        }
    }
}