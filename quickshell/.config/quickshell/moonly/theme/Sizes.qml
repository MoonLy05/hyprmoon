pragma Singleton
import Quickshell
import QtQuick

Singleton {
    // Barras
    readonly property int leftBarWidth: gap + verticalPillWidth + gap
    readonly property int topBarHeight: gap + horizontalPillHeight + gap
    readonly property int workspacesPerMonitor: 5

    // Pastillas
    readonly property int horizontalPillHeight: 30
    readonly property int verticalPillWidth: 34
    readonly property int verticalPadding: 12

    
    // Espacios
    readonly property int gap: 5
    readonly property int gapText: 5
    readonly property int gapItems: 10

    //Componentes
    readonly property int iconButtonSize: 30
    readonly property int panelRadius: 16
    readonly property int cardRadius: 12
}