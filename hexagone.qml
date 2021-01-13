import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.6
import QtQuick.Controls 2.5
MapPolygon
{
    id: marker
    opacity: 0.10
    autoFadeIn : false
    property var coordinate:
    {
        latitude: 0
        longitude : 0
    }

    property var antenne
    property var dialog
    property var puissanceRecue
    MouseArea{
        id: mouse
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: "RightButton"
        hoverEnabled: true
        onClicked: {

            dialog = showDialogAdd()
            dialog.visible = true
        }

    }
    ToolTip {
        id: toolTip
        text: textToolTip()
        delay: 1000
        visible: mouse.containsMouse
    }

    function textToolTip() {
        if(this.antenne === undefined){
            return "Zone non couverte, cliquez boutton droite pour ajouter une antenne"
        } else {
            return "Zone couverte par l'antenne: " + this.antenne.nom + "\nPuissance reçue " + this.puissanceRecue
        }
    }

    function showDialogAdd(){
        var component = Qt.createComponent("qrc:///ajoutAntenne.qml");
        var dialog = component.createObject(window);
        dialog.label = "Ajouter une antenne"
        dialog.antennePos = " "
        dialog.getCoordinate(coordinate.latitude, coordinate.longitude);
        return dialog
    }
}





