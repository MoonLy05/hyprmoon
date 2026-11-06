import QtQuick
import Quickshell
import qs.components
import qs.theme

Pill {
    
    clickable: true
    
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    
    anchors.centerIn: parent
    onClicked: Quickshell.execDetached(["gnome-calendar"])

    Column {

        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            font.bold: true
        }

        PillText {
            anchors.horizontalCenter: parent.horizontalCenter
            text: clock.date.toLocaleString(Qt.locale("es_MX"), "ddd d'/'MMMM'/'yyyy")
            opacity: 0.8
            font.pixelSize: Fonts.small
        }
    }
}