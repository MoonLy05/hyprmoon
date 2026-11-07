import QtQuick
import Quickshell.Services.UPower
import qs.components
import qs.theme
import Quickshell

Pill {
    id: root

    clickable: true

    readonly property var dev: UPower.displayDevice

    readonly property int pct: Math.round(dev.percentage * 100)

    readonly property bool charging: dev.state == UPowerDeviceState.Charging

    readonly property bool fullcharged: dev.state == UPowerDeviceState.FullyCharged

    readonly property bool plugged: (charging || fullcharged)

    readonly property bool veryLowBattery: pct < 20

    readonly property bool mediumBattery: pct < 50

    readonly property int seconds: charging ? dev.timeToFull : dev.timeToEmpty

    onClicked: Quickshell.execDetached(["rog-control-center"])

    readonly property string timeText: {
        if (seconds <= 0)
            return "calculando…"
        const h = Math.floor(seconds / 3600)
        const m = Math.floor((seconds % 3600) / 60)
        return h + " h " + m + " min"
    }
    
    tooltipText: fullcharged ? "Batería cargada"
               : charging    ? "Cargando · " + timeText + " para llenarse"
               :               "Descargando · " + timeText + " restantes"

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
        spacing: Sizes.gapText
        
        PillText {
            text: icons
            color: textColor
        }
        
        PillText {
            text: pct + "%"
            color: textColor
        }
    }
}