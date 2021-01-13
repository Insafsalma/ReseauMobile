import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0
import QtPositioning 5.6

Window {
    id: addWindow
    width: 256
    height: 256
    property var antennePos
    property var puissance
    property var frequence
    property var nom
    property var coordinate
    property var label

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Column {
            id: column
            x: 169
            y: 93
            anchors.rightMargin: 0
            anchors.fill: parent

            Label {
                id: labelShow
                text: label
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.right
                anchors.rightMargin: 45
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                id: positionAntenne
                text: antennePos
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.right
                anchors.rightMargin: 45

            }

            TextField {
                id: txtNom
                text: nom
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.right
                anchors.rightMargin: 45
                placeholderText: "Nom de l'antenne"
            }

            TextField {
                id: txtPuissance
                text: puissance
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.right
                anchors.rightMargin: 45
                placeholderText: "Puissance de l'antenne"
            }

            TextField {
                id: txtFrequence
                text: frequence
                horizontalAlignment: Text.AlignHCenter
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.right
                anchors.rightMargin: 45
                placeholderText: "Fréquence de l'antenne"
            }

            Button {
                id: addBtn
                text: qsTr("Confirmer")
                anchors.right: parent.right
                anchors.rightMargin: 45
                anchors.left: parent.left
                anchors.leftMargin: 45
                onClicked: {
                    if(label == "Ajouter une antenne"){
                        nom = txtNom.text
                        puissance = Number(txtPuissance.text)
                        frequence = Number(txtFrequence.text)
                        addAntenneDialog()
                        assignAntenneToHexagone();
                        addWindow.close()
                    } else if(label == "Modifier une antenne"){
                        var antenne = listAntennes[antennePos];
                        antenne.nom = txtNom.text
                        antenne.puissance = Number(txtPuissance.text)
                        antenne.frequence = Number(txtFrequence.text)
                        antenne.coordinate = coordinate;
                        listAntennes[antennePos] = antenne

                        assignAntenneToHexagone();
                        addWindow.close()
                    }

                }
            }

        }


    }

    function addAntenneDialog(){
        var component = Qt.createComponent("qrc:///antenne.qml");
        var antenne = component.createObject(window);

        antenne.coordinate = coordinate;
        antenne.puissance = puissance;
        antenne.nom = nom;
        antenne.frequence = frequence;
        listAntennes.push(antenne);
        map.addMapItem(antenne);
    }

    function getCoordinate(centerLatitude, centerLongitude) {
        var coordinateS = QtPositioning.coordinate(centerLatitude, centerLongitude);
        coordinate = coordinateS;
    }

    function setPos(pos){

        this.antennePos = pos
    }
}



