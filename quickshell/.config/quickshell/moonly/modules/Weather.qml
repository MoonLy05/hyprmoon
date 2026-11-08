import QtQuick
import Quickshell.Io
import qs.components
import qs.theme
import Quickshell
import qs.services


Pill {
    id: root

    clickable: true

    onClicked: Quickshell.execDetached(["xdg-open", "https://wttr.in"])

    tooltipText: "Ubicación: " + WeatherService.location + "\nTemperatura: " + WeatherService.temperature + "\nSensación: " + WeatherService.sensation + "\nHumedad: " + WeatherService.humidity + "\nViento: " + WeatherService.wind

    Row {
        spacing: Sizes.gapText

        PillText {
            text: WeatherService.temperature
            font.pixelSize: Fonts.small
            font.bold: true
        }

        PillText {
            text: WeatherService.weather
            font.pixelSize: Fonts.small
            opacity: 0.7
        }
    }
}