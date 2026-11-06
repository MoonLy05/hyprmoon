pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int leftBarWidth: 38
    readonly property int verticalPillWidth: leftBarWidth - 4
    readonly property int verticalPadding: 12
    readonly property int gap: 5
    readonly property int workspacesPerMonitor: 5
}