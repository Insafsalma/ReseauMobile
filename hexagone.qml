import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.6
import QtQuick.Controls 2.5
MapPolygon
{
    id: marker
    opacity: 0.10
    autoFadeIn : false
    property var antennePos
    property var puissance
    property var frequence
    property var nom
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

            nom = "antenne"
            puissance = 1
            frequence = 99
            ajouterAntenne()
            assignAntenneToHexagone();

        }

    }

    MouseArea{
        id: mouseAntenne
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: "LeftButton"
        hoverEnabled: true
        onClicked: {

            nom = "antenne"
            puissance = 1
            frequence = 99
            ajouterAntenne()
            assignAntenneToHexagone();

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

    function ajouterAntenne(){
        var component = Qt.createComponent("qrc:///antenne.qml");
        var antenne = component.createObject(window);

        antenne.coordinate = coordinate;
        antenne.puissance = puissance;
        antenne.nom = nom+" "+coordinate;
        antenne.frequence = frequence;
        listAntennes.push(antenne);
        map.addMapItem(antenne);

    }
}





