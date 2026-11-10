import QtQuick
import qs.theme

Rectangle {
    id: root

    property real value: 0
    property bool vertical: false
    property int length: 200
    property int thickness: 12
    property real step: 0.05
    property alias fillColor: fill.color
    property alias pressed: area.pressed
    signal moved(real newValue)

    implicitWidth: vertical ? thickness : length
    implicitHeight: vertical ? length : thickness
    radius: Math.min(width, height) / 2
    color: ColorsMatugen.inactive

    function fractionAt(x, y) {
        const f = vertical ? 1 - y / height : x / width
        return Math.max(0, Math.min(1, f))
    }
    
    function stepBy(wheel) {
        const level = root.value / root.step
        const target = wheel.angleDelta.y > 0
            ? Math.floor(level + 0.001) + 1
            : Math.ceil(level - 0.001) - 1
        root.moved(Math.max(0, Math.min(1, target * root.step)))
    }

    Rectangle {
        id: fill
        width: root.vertical ? parent.width : parent.width * root.value
        height: root.vertical ? parent.height * root.value : parent.height
        y: root.vertical ? parent.height - height : 0
        radius: parent.radius
        color: ColorsMatugen.primary
    }

    MouseArea {
        id: area
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: (mouse) => root.moved(root.fractionAt(mouse.x, mouse.y))
        onPositionChanged: (mouse) => root.moved(root.fractionAt(mouse.x, mouse.y))
        onWheel: (wheel) => root.stepBy(wheel)
    }
}