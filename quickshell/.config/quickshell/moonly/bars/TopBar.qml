import QtQuick
import Quickshell
import qs.components 
import qs.modules
import qs.theme

// importa todo lo de la carpeta components/

PanelWindow {

    required property var modelData

    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: Sizes.verticalPillWidth
    color: "transparent"

    Row {
        spacing: Sizes.gap
        anchors.left: parent.left
        anchors.leftMargin: Sizes.gap + Sizes.leftBarWidth
        anchors.verticalCenter: parent.verticalCenter
        
        WindowTitle{
        }

        Weather{
            
        }

        Keyboard {
            
        }
    }

    Clock {
    }

    Row {

        spacing:Sizes.gap
        anchors.right:parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: Sizes.gap

        Media {
            
        }

        Hardware {
        }

        Battery {
        }
        
    }

}