import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtLocation 5.15
import QtPositioning 5.15

import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick 2.3
import QtPositioning 5.5
import QtLocation 5.6

//import GeneralMagic 1.0




ApplicationWindow {
    id: window
    width: 600
    height: 600
    visible: true

    property var listHexagones: []
    property var listAntennes: []

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        //specify plugin parameters if necessary
        //PluginParameter {...}
        //PluginParameter {...}
        //...
    }

    Map {
        id: map
        width: 600
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: -19
        anchors.leftMargin: 0
        anchors.topMargin: 19
        plugin: mapPlugin
        center: QtPositioning.coordinate(47.746, 7.3384) // Mulhouse
        zoomLevel: 14

        Timer {
              interval: 500; running: true; repeat: true
              onTriggered: time.text = Date().toString()
        }
        Text {
              id: time
              x: 249
              y: 0
              width: 102
              height: 22
              font.pixelSize: 24
              horizontalAlignment: Text.AlignHCenter
              wrapMode: Text.NoWrap
              styleColor: "#c51414"
              font.bold: true
              font.family: "Times New Roman"
        }
        MouseArea {
                anchors.fill: parent
                onPressed: console.log('latitude = '+ (map.toCoordinate(Qt.point(mouse.x,mouse.y)).latitude),
                                       'longitude = '+ (map.toCoordinate(Qt.point(mouse.x,mouse.y)).longitude));
        }
        MapItemView {
            model: routeModel
            delegate: Component {
                MapRoute {
                    route: routeData
                    line.color: "blue"
                    line.width: 4
                }
            }
        }
        RouteModel {
            id: routeModel
            plugin: map.plugin
            query: RouteQuery { id: routeQuery }
            Component.onCompleted: {
                routeQuery.addWaypoint(QtPositioning.coordinate(47.749676, 7.340333));
                routeQuery.addWaypoint(QtPositioning.coordinate(47.728204, 7.308574));
                routeQuery.addWaypoint(QtPositioning.coordinate(47.732828, 7.352456));
                routeQuery.addWaypoint(QtPositioning.coordinate(47.766266, 7.384423));
                routeQuery.addWaypoint(QtPositioning.coordinate(47.749676, 7.340333));
                RouteQuery.CarTravel;
                update();
            }
        }



    /*    MapQuickItem {
                   id: arrow
                   coordinate:  QtPositioning.coordinate(47.749676, 7.340333)
                 //  NumberAnimation on rotation { from: 0; to: 180; duration: 2000; loops: Animation.Infinite; }
                   NumberAnimation {
                          from: smiley.minHeight; to: smiley.maxHeight
                          easing.type: Easing.OutExpo; duration: 300
                      }
                   anchorPoint.x: img.width/2
                   anchorPoint.y: img.height/2
                   sourceItem: Image {
                       id: img
                       source: "antenne.png"
                   }
               }*/

    }

    function dessinerHexagone(latitude, longitude, couleur, centreLongitude, centreLatitude){

        var component = Qt.createComponent("qrc:///hexagone.qml");
        var polygon = component.createObject(window);
        var coordoneeCentre = QtPositioning.coordinate(centreLatitude, centreLongitude);

        for(var i=0; i < latitude.length; i++){
            var coordinate = QtPositioning.coordinate(latitude[i], longitude[i]);
            polygon.addCoordinate(coordinate);
            polygon.color =  "#" + couleur;
            polygon.coordinate = coordoneeCentre;
            listHexagones.push(polygon);
        }
        map.addMapItem(polygon);

    }

    function addAntenne(){

        for (var i = 0; i < latitude.length; i++){
            var coordinate = QtPositioning.coordinate(latitude[i], longitude[i]);
            var component = Qt.createComponent("qrc:///antenne.qml");
            var antenne = component.createObject(window);
            antenne.coordinate = coordinate;
            antenne.puissance = puissance[i];
            antenne.frequence = frequence[i];
            listAntennes.push(antenne);
            map.addMapItem(antenne);
        }
        assignAntenneToHexagone();
    }

    function assignAntenneToHexagone(){
        var puissanceRecueMax;
        var positionAntenne = 0;
        for(var i = 0; i < listHexagones.length; i++){
            if(listAntennes.length == 0){
                listHexagones[i].antenne = undefined
                listHexagones[i].color = "#586036"
                listHexagones[i].opacity = 0.25
                listHexagones[i].puissanceRecue = 0

            } else {
                var puissanceRecueAncienne = 0;
                for(var j=0; j < listAntennes.length; j++){
                    var puissanceRecue = listAntennes[j].puissance / (4 * Math.PI * (listHexagones[i].coordinate.distanceTo(listAntennes[j].coordinate))+0.0005)*1000;
                    if(puissanceRecue > puissanceRecueAncienne){
                        puissanceRecueAncienne = puissanceRecue;
                        positionAntenne = j;

                    }
                }
                listHexagones[i].antenne = listAntennes[positionAntenne];
                listHexagones[i].opacity = 0.25 * puissanceRecueAncienne / listAntennes[positionAntenne].puissance * 10;
                listHexagones[i].puissanceRecue = puissanceRecueAncienne
            }

        }
    }


}
