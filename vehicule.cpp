#include "vehicule.h"
#include "point.h"

Vehicule::Vehicule():d_position{Point()}
{}
void Vehicule::deplacer(const Point &p)
{
   d_position=p;
}

