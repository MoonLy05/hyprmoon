import QtQuick
import Quickshell
import qs.components
import qs.theme
import QtQuick.Effects

Pill {
    id: root

    property alias icon: iconText.text
    property alias iconColor: iconText.color
    signal confirmed()
    property bool holdToConfirm: false
    property real progress: 0
    property int holdDuration: 1200

    clickable: true
    color: ColorsMatugen.textOnSurface

    implicitWidth: Sizes.iconButtonSize
    implicitHeight: Sizes.iconButtonSize

    NumberAnimation {
        id: holdAnim
        target: root
        easing.type: Anim.easing
        property: "progress"    
        from: 0
        to: 1
        duration: root.holdDuration
        onFinished: root.confirmed()
    }

    Item {
        width: root.width
        height: root.height

        layer.enabled: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskSource: circleMask
            }
            
        Rectangle {
            id: circleMask
            anchors.fill: parent
            radius: width / 2
            visible: false
            layer.enabled: true
        }

    
        Rectangle {
            width: parent.width * root.progress
            color: ColorsMatugen.primary
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    
        PillText {
            id: iconText
            anchors.centerIn: parent
            color: ColorsMatugen.surfaceContainer
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.holdToConfirm
            onPressed: holdAnim.restart()
            onReleased: {
                holdAnim.stop()
                root.progress = 0
            }
            onCanceled: {
                holdAnim.stop()
                root.progress = 0
            }
        }
    }
}