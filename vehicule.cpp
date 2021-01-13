#include "vehicule.h"
#include "point.h"

Vehicule::Vehicule():d_position{Point(0,0)}
{
}
Vehicule::Vehicule(Point position):d_position{position}
{
}
void Vehicule::deplacer(const Point &p)
{
   d_position=p;
}
Point Vehicule::getPosition(int time)
{
    return d_position_info[time];
}
void Vehicule::setPositionInfo(Point posInfo[])
{
    for(int i=0; i<24; i++)
    {
      d_position_info[i]=posInfo[i];
    }
}

