import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtLocation 5.15
import QtPositioning 5.15

Window {
    width: 600
    height: 600
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        width: 600
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: -19
        anchors.leftMargin: 0
        anchors.topMargin: 19
        plugin: mapPlugin
        center: QtPositioning.coordinate(47.746, 7.3384) // Mulhouse
        zoomLevel: 14
        Text {
            id: timer
            x: 249
            y: 0
            width: 102
            height: 22
            text: Qt.formatTime(new Date(),"hh:mm:ss")
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            styleColor: "#c51414"
            font.bold: true
            font.family: "Times New Roman"
        }
    }

}

