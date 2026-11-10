import QtQuick
import qs.theme
import Quickshell

Rectangle {
    id: root

    default property alias content: box.data

    readonly property bool showTip: mouse.containsMouse && root.tooltipText !== ""  

    property int verticalPadding: Sizes.gap
    property string tooltipText: ""
    property bool scrollable: false
    signal clicked(var mouse)
    signal scrolled(var wheel)
    property int tooltipEdge: Edges.Bottom
    property bool clickable: false
    property int padding: 18      
    clip: true

    implicitWidth: box.implicitWidth + padding * 2
    implicitHeight: Math.max(Sizes.horizontalPillHeight, box.implicitHeight + verticalPadding * 2)
    radius: Math.min(width, height) / 2
    color: ColorsMatugen.surfaceContainer

    Behavior on implicitWidth {
        NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
    }

    Behavior on implicitHeight {
        NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
    }
    
    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: root.clickable || root.scrollable || root.tooltipText !== ""
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: (mouse) => { if (root.clickable) root.clicked(mouse) }
        onWheel: (wheel) => { if (root.scrollable) root.scrolled(wheel) }
    }

    PopupWindow {
        anchor.item: root
        anchor.edges: root.tooltipEdge
        anchor.gravity: root.tooltipEdge
        visible: root.showTip || bg.opacity > 0        // NUEVO (reemplaza tu visible anterior)
        color: "transparent"
        implicitWidth: tip.width + 16
        implicitHeight: tip.height + 10
    
        Rectangle {
            id: bg                                     // NUEVO
            anchors.fill: parent
            radius: 8
            color: ColorsMatugen.surfaceContainer
            opacity: root.showTip ? 1 : 0              // NUEVO
    
            Behavior on opacity {                      // NUEVO
                NumberAnimation { duration: Anim.normal }
            }
    
            PillText {
                id: tip
                anchors.centerIn: parent
                text: root.tooltipText
                maxWidth: 350
            }
        }
    }

    Item {
        id: box
        anchors.centerIn: parent
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}