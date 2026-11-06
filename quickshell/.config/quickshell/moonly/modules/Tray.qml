import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.components
import qs.theme
import QtQuick.Effects

Pill {
    id: root
    implicitWidth: Sizes.verticalPillWidth
    verticalPadding: Sizes.verticalPadding

    Column {
        spacing: 8

        Repeater{
            model: SystemTray.items

            IconImage {
                id: icon
                required property var modelData
                anchors.horizontalCenter: parent.horizontalCenter
                source: modelData.icon
                implicitSize: 18

                QsMenuAnchor {
                    id: menuAnchor
                    menu: modelData.menu
                    anchor.item: icon
                    anchor.edges: Edges.Right
                    anchor.gravity: Edges.Right
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.LeftButton)
                            modelData.activate()
                        else if (modelData.hasMenu)
                            menuAnchor.open()
                    }
                }
            }
        }
    }
}