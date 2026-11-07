import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.theme

Column {
    id: root
    
    property var monitor

    readonly property int base: monitor && monitor.activeWorkspace
                                ? Math.floor((monitor.activeWorkspace.id - 1) / Sizes.workspacesPerMonitor) * Sizes.workspacesPerMonitor
                                : 0
                                
    Pill {      
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: Sizes.verticalPillWidth
        verticalPadding: Sizes.verticalPadding                     
    
        Column {
            spacing: Sizes.gapItems
    
            Repeater {
                model: Sizes.workspacesPerMonitor
    
                Rectangle {
                    required property int index
                    readonly property int wsId: root.base + index + 1
                    readonly property bool active: root.monitor !== null
                                                   && root.monitor.activeWorkspace !== null
                                                   && root.monitor.activeWorkspace.id === wsId
    
                    width: 20
                    height: active ? 35 : 25
                    radius: width / 2
                    color: active ? ColorsMatugen.primary : "transparent"                    
    
                    Behavior on color {
                        ColorAnimation { duration: 250 }
                    }

                    Behavior on height {
                        SpringAnimation { spring: 4; damping: 0.3 }
                    }
    
                    PillText {
                        anchors.centerIn: parent
                        text: index + 1
                        color: active ? ColorsMatugen.textOnPrimary : ColorsMatugen.textOnSurface
                        font.bold: active
                        font.pixelSize: Fonts.small
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (wsId) + " })")                    }
                }
            }
        }
    }
}