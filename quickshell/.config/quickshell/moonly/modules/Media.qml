import QtQuick
import Quickshell.Services.Mpris
import qs.components
import qs.theme

Pill {
    id: root
    
    readonly property var prioridad: ["Sidra", "Spotify", "Brave"]
    readonly property var player: {
        for ( const n of prioridad ) {
           	for ( const p of Mpris.players.values) {
                if (p.identity === n && p.isPlaying) {
                    return p
                }
            }
        }
        for (const n of prioridad) {
                for (const p of Mpris.players.values) {
                    if (p.identity === n) {
                        return p
                    }
                }
            }
        
            return null
    }

    visible: player !== null

    PillText {
        text: player ? " " + player.trackArtist + " — " + player.trackTitle : ""
        width: Math.min(implicitWidth, 250)
        font.pixelSize: Fonts.small
    }
}