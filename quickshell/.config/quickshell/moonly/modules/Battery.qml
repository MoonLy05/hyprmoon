import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.theme

Pill {
    id: root

    // Paso 2: ¿de dónde sale el dato?
    readonly property var dev: UPower.displayDevice

    // Paso 3: percentage viene de 0 a 1. ¿Cómo lo vuelves un entero de 0 a 100?
    readonly property int pct: Math.round(dev.percentage * 100)

    // Paso 3: ¿cuándo cuenta como "cargando"?
    readonly property bool charging: dev.state == UPowerDeviceState.Charging

    readonly property bool fullcharged: dev.state == UPowerDeviceState.FullyCharged

    readonly property bool plugged: (charging || fullcharged)

    readonly property bool veryLowBattery: pct < 20

    readonly property bool mediumBattery: pct < 50

    readonly property string icons: {
        if (plugged)
            return "󰂄"
        else if (veryLowBattery)
            return "󰁻"
        else if (mediumBattery)
            return "󰁼"
        else
            return "󰁹"
    }

    readonly property color textColor: plugged ? ColorsMatugen.textOnPrimary
                                     : veryLowBattery ? ColorsMatugen.textOnError : ColorsMatugen.textOnSurface
    
    color:  plugged ? ColorsMatugen.primary 
         : veryLowBattery ? ColorsMatugen.error : ColorsMatugen.surfaceContainer

    Row {
        spacing: 5
        
        PillText {
            text: icons
            color: textColor
        }
        
        PillText {
            text: pct + "%"
            color: textColor
        }
    }
    Behavior on color {
        ColorAnimation { duration: 400 }
    }
}