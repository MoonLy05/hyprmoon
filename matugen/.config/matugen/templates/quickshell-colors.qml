pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property color surfaceContainer: "{{colors.surface_container.default.hex}}"
    readonly property color textOnSurface: "{{colors.on_surface.default.hex}}"
    readonly property color primary: "{{colors.primary.default.hex}}"
    readonly property color textOnPrimary: "{{colors.on_primary.default.hex}}"
    readonly property color error: "{{colors.error.default.hex}}"
    readonly property color textOnError: "{{colors.on_error.default.hex}}"
    readonly property color inactive: "{{colors.outline.default.hex}}"
    readonly property color surfaceContainerHigh: "{{colors.surface_container_high.default.hex}}"
}