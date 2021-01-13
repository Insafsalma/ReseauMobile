import QtQuick 2.0
import QtLocation 5.15
import QtPositioning 5.6
import QtQuick.Controls 2.5

/*MapCircle {
    property var coordinate:
    {
        latitude: 5
        longitude : 0
    }
    radius: 10.0
    color:  "red"
    border.color: "red"
    border.width: 1
              }*/
MapPolygon
{
    id: marker
    opacity: 0.50
  //  autoFadeIn : false
    property var coordinate:
    {
        latitude: 5
        longitude : 0
    }
}
