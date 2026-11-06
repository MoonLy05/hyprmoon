import QtQuick

Item {
    property alias text: label.text
    property alias fontSize: label.font.pixelSize
    property alias color: label.color

    implicitWidth: label.implicitHeight
    implicitHeight: label.implicitWidth

    PillText {
        id: label
        anchors.centerIn: parent
        rotation: -90
    }
}