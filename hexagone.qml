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
}



