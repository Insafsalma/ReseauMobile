#ifndef VEHICULE_H
#define VEHICULE_H
#include "point.h"

class Vehicule
{
    public:
        Vehicule();
        void deplacer(const Point &p);
    private:
        Point d_position;
};

#endif // VEHICULE_H
