pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int leftBarWidth: gap + verticalPillWidth + gap
    readonly property int horizontalPillHeight: 30
    readonly property int topBarHeight: gap + horizontalPillHeight + gap
    readonly property int verticalPillWidth: 34
    readonly property int verticalPadding: 12
    readonly property int gap: 5
    readonly property int gapText: 5
    readonly property int gapItems: 10
    readonly property int workspacesPerMonitor: 5
}