import QtQuick
import Quickshell
import qs.components
import qs.theme

Pill {
    clickable: true
    onClicked: Quickshell.execDetached(["gnome-calendar"])
    tooltipText: clock.date.toLocaleString(Qt.locale("es_MX"), "dddd d 'de' MMMM 'de' yyyy")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Row {
        spacing: Sizes.gapText

        PillText {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            font.bold: true
        }

        PillText {
            anchors.verticalCenter: parent.verticalCenter
            text: clock.date.toLocaleString(Qt.locale("es_MX"), "ddd d MMM")
            opacity: 0.8
            font.pixelSize: Fonts.small
        }
    }
}