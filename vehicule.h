#ifndef VEHICULE_H
#define VEHICULE_H
#include "point.h"
#include "hexagone.h"
#include <string>
using namespace std;

class Vehicule
{
    public:
        Vehicule();
        Vehicule(Point position);
        void deplacer(const Point &p);
        Point getPosition(int time);
        void setPositionInfo(Point posInfo[]);
    private:
        Point d_position;
        double d_vitesse;
        Point d_position_info[24];


};

#endif // VEHICULE_H
