import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 2.5

MapQuickItem {
    id: antenne
    anchorPoint.x: icon.width * 0.5
    anchorPoint.y: icon.height * 0.8
    property var puissance
    property var frequence
    property var nom

    sourceItem: Image {
        id: icon
        source: "antenne.png"
        sourceSize.width: 60
        sourceSize.height: 60
    }

    MouseArea {
        id: mouseA
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            antenneMenu.visible = true
        }
    }

    ToolTip {
        id: toolTip
        text: textAntenneToolTip()
        delay: 1000
        visible: mouseA.containsMouse
    }

    function textAntenneToolTip() {
        return "Nom de l'antenne " + this.nom +"\nFréquence de l'antenne: " +this.frequence + "\nPuissance de l'antenne "+this.puissance
    }

}

