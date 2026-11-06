import QtQuick
import Quickshell
import qs.modules
import qs.theme
import Quickshell.Hyprland

PanelWindow {

    id: root
    required property var modelData

    screen: modelData
    
    anchors {
        left: true
        top: true
        bottom: true
    }
    implicitWidth: Sizes.leftBarWidth
    color: "transparent"

    Workspaces {
        monitor: Hyprland.monitorFor(root.screen)
        anchors.top: parent.top                            
        anchors.topMargin: Sizes.gap
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Sizes.gap
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Sizes.gap
    
        Updates {}
        Audio {}
        Tray {}
    }
}