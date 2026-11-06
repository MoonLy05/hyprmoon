import QtQuick
import qs.theme
import Quickshell

Rectangle {
    id: root

    default property alias content: box.data
   
    property int verticalPadding: 5
    property string tooltipText: ""
    property bool scrollable: false
    signal clicked(var mouse)
    signal scrolled(var wheel)
    property int tooltipEdge: Edges.Bottom
    property bool clickable: false
    property int padding: 18      
    clip: true

    implicitWidth: box.implicitWidth + padding * 2
    implicitHeight: Math.max(30, box.implicitHeight + verticalPadding * 2)
    radius: Math.min(width, height) / 2
    color: ColorsMatugen.surfaceContainer

    Behavior on implicitWidth {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    Behavior on implicitHeight {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
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
        anchor.item: root                 // se ancla a esta pastilla
        anchor.edges: root.tooltipEdge
        anchor.gravity: root.tooltipEdge      
        visible: mouse.containsMouse && root.tooltipText !== ""
        color: "transparent"
        implicitWidth: tip.implicitWidth + 16
        implicitHeight: tip.implicitHeight + 10
    
        Rectangle {
            
            anchors.fill: parent
            radius: 8
            color: ColorsMatugen.surfaceContainer
    
            PillText {
                id: tip
                anchors.centerIn: parent
                text: root.tooltipText
            }
        }
    }

    // Caja que se ajusta a lo que tenga dentro
    Item {
        id: box
        anchors.centerIn: parent
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height
    }
}