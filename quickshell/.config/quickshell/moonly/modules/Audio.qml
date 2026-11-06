import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.components
import qs.theme

Pill {
    id: root

    function alternarMute(destino) {
        destino.audio.muted = !destino.audio.muted
    }
    
    function cambiarVolumen(destino, wheel) {
        const paso = wheel.angleDelta.y > 0 ? 0.05 : -0.05
        destino.audio.volume = Math.max(0, Math.min(1, destino.audio.volume + paso))
    }

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool isMuted: sink && sink.audio.muted
    readonly property int speakerVolume: sink ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool speakerOff: isMuted || speakerVolume === 0
    
    readonly property var source: Pipewire.defaultAudioSource
    readonly property bool isMutedMic: source && source.audio.muted
    readonly property int volumeMic: source ? Math.round(source.audio.volume * 100) : 0
    readonly property bool micOff: isMutedMic || volumeMic === 0

    implicitWidth: Sizes.verticalPillWidth
    verticalPadding: Sizes.verticalPadding  
    
    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    readonly property string iconVolume: {
        if (isMuted || speakerOff)
            return "󰝟"
        else if (speakerVolume <= 30)
            return "󰕿"
        else if (speakerVolume <= 70)
            return "󰖀"
        else
            return "󰕾"
    }

    readonly property string iconMic: {
        if (isMutedMic || micOff)
            return "󰍭"
        else
            return "󰍬"
    }

    Column {
        spacing: 15
        
        VerticalText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: micOff ? iconMic : iconMic + " " + volumeMic + "%"
            fontSize: Fonts.small
            color: micOff ? ColorsMatugen.inactive : ColorsMatugen.textOnSurface

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.alternarMute(root.source)
                onWheel: (wheel) => root.cambiarVolumen(root.source, wheel)
            }
        }

        VerticalText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: speakerOff ? iconVolume : iconVolume + " " + speakerVolume + "%"
            fontSize: Fonts.small
            color: speakerOff ? ColorsMatugen.inactive : ColorsMatugen.textOnSurface

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.alternarMute(root.sink)
                onWheel: (wheel) => root.cambiarVolumen(root.sink, wheel)
            }
        }
    }
}