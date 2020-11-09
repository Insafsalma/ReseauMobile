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
                update();

            }
        }

    }

}
