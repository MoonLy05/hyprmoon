import QtQuick
import Quickshell
import qs.components
import qs.theme
import Quickshell.Hyprland
import qs.services
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Pill {
    id: root

    clickable: true
    onClicked: open = !open
    
    property bool open: false
    readonly property var sink: Pipewire.defaultAudioSink

    PwObjectTracker {
            objects: [root.sink]
        }

    HyprlandFocusGrab {
        windows: [panel, QsWindow.window]
        active: root.open
        onCleared: root.open = false
    }
    
    PopupPanel {
        id: panel
        target: root
        open: root.open
        panelWidth: layout.implicitWidth + (Sizes.gapItems * 2)
        panelHeight: layout.implicitHeight + (Sizes.gapItems * 2)

        Row{
            id: layout
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: Sizes.gapItems
            spacing: Sizes.gapItems
            
            Card{
                Column {
                    
                    spacing: Sizes.gapItems
                    
                    IconButton {
                        anchors.horizontalCenter: parent.horizontalCenter
                        icon: root.sink && root.sink.audio.muted ? "󰝟" : "󰕾"
                        tooltipText: "Silenciar"
                        onClicked: root.sink.audio.muted = !root.sink.audio.muted
                    }
                    
                    Slider {
                        anchors.horizontalCenter: parent.horizontalCenter
                        vertical: true
                        value: root.sink ? root.sink.audio.volume : 0
                        onMoved: (v) => root.sink.audio.volume = v
                        thickness: 16
                    }

                    PillText {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: root.sink ? Math.round(root.sink.audio.volume * 100) : 0 + "%"
                    }
                    
                } 
            }

            Column{
                
                spacing: Sizes.gapItems

                Card {
                    id: headerCard
                    Row {
                        
                        spacing: Sizes.gapItems
                        
                        ClippingRectangle {
                            width: 40
                            height: 40
                            radius: width / 2
                        
                            Image {
                                anchors.fill: parent
                                source: "file://" + Quickshell.env("HOME") + "/.face"
                                fillMode: Image.PreserveAspectCrop
                            }
                        }
                    
    
                    Column {
    
                        anchors.verticalCenter: parent.verticalCenter
                        
                        PillText {
                            text: Quickshell.env("USER")
                            font.pixelSize: Fonts.large
                            font.bold: true
                        }
    
                        PillText {
                            text: "Encendido: " + SystemService.timeText
                            font.pixelSize: Fonts.small
                            opacity: 0.7
                        }
                    }
                }
            }
                
                Card{
                    width: headerCard.width
                    Row{

                        spacing: Sizes.gapItems
                        
                        IconButton {
                            icon: "⏻"
                            tooltipText: "Apagar"
                            holdToConfirm: true
                            onConfirmed: Quickshell.execDetached(["systemctl", "poweroff"])
                        }
            
                        IconButton {
                            icon: "󰜉"
                            tooltipText: "Reiniciar"
                            holdToConfirm: true
                            onConfirmed: Quickshell.execDetached(["systemctl", "reboot"])
                        }
            
                        IconButton {
                            icon: "󰍃"
                            tooltipText: "Cerrar Sesión"
                            holdToConfirm: true
                            onConfirmed: Hyprland.dispatch("hl.dsp.exit()")
                        }
            
                        IconButton {
                            icon: NotificationService.molestarDnd ? "󰂛" : "󰂚"
                            onClicked: NotificationService.alternateDnd()
                            tooltipText: NotificationService.molestarDnd ? "No molestar" : "Notificaciones en espera: " + NotificationService.numNotifications
                            iconColor: NotificationService.molestarDnd ? ColorsMatugen.inactive : ColorsMatugen.textOnPrimary
                        }
                    }
                }
            }
        }
    }
    
    PillText {
        text: "󰣇"
    }
}