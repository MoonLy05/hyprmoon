pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int easing: Easing.OutCubic
    readonly property int fast: 125
    readonly property int normal: 275
    readonly property int slow: 350 
}