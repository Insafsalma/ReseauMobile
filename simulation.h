#ifndef SIMULATION_H
#define SIMULATION_H
#include "vehicule.h"
#include <vector>

class simulation
{
public:
    simulation();
    void start();
    void remplir_vehicules(Point itineraires[100][24]);
    void deplacement_vehicule();
private:
    vector<Vehicule> d_vehicules;
};

#endif // SIMULATION_H
