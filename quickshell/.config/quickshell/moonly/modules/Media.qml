import QtQuick
import Quickshell.Services.Mpris
import qs.components
import qs.theme

Pill {
    id: root
    clickable: true

    onClicked: player.togglePlaying()

    scrollable: true

    onScrolled: (wheel) => {
        if (wheel.angleDelta.y > 0)
            player.next()
        else
            player.previous()
    }
    
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

    tooltipText: player ? "Reproductor: " + player.identity
                        + "\nTítulo: " + player.trackTitle
                        + "\nArtista: " + player.trackArtist
                        + "\nÁlbum: " + player.trackAlbum
                        : ""

    visible: player !== null

    readonly property string iconPlayer: player && player.isPlaying ? "" : ""

    PillText {
        text: player ? iconPlayer + " " + player.trackArtist + " — " + player.trackTitle : ""        
        font.pixelSize: Fonts.small
    }
}