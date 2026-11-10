import Quickshell
import QtQuick
import qs.theme

Text {
    property int maxWidth: 250
    font.family: Fonts.family
    font.pixelSize: Fonts.normal
    color: ColorsMatugen.textOnSurface
    elide: Text.ElideRight
    width: Math.min(implicitWidth, maxWidth)
    Behavior on color {
        ColorAnimation { duration: Anim.normal }
    }
}