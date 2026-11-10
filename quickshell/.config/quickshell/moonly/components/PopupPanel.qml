import QtQuick
import Quickshell
import qs.theme

PopupWindow {
    id: root

    property Item target
    property bool open: false
    property int panelWidth: 500
    property int panelHeight: 500

    default property alias content: bg.data

    anchor.item: root.target
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom | Edges.Left

    visible: root.open || bg.opacity > 0                 
    implicitWidth: root.panelWidth
    implicitHeight: root.panelHeight + Sizes.gap
    color: "transparent"

    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.topMargin: Sizes.gap
        radius: Sizes.panelRadius
        color: ColorsMatugen.surfaceContainer

        opacity: root.open ? 1 : 0                        
        scale: root.open ? 1 : 0.9                       
        transformOrigin: Item.TopRight                    
        
        Behavior on opacity {                             
            NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
        }
        Behavior on scale {                               
            NumberAnimation { duration: Anim.normal; easing.type: Anim.easing }
        }
    }
}