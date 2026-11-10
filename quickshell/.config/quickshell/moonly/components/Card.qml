import QtQuick
import qs.theme

Rectangle {
    id: root

    default property alias content: box.data

    property bool scrollable: false
    property int padding: Sizes.gapItems     
    clip: true

    implicitWidth: box.implicitWidth + padding * 2
    implicitHeight: box.implicitHeight + padding * 2
    color: ColorsMatugen.surfaceContainerHigh
    radius: Sizes.cardRadius

    Behavior on implicitWidth {
        NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
    }

    Behavior on implicitHeight {
        NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
    }

    Item {
        id: box
        anchors.centerIn: parent
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}