#include "simulation.h"
#include "point.h"
#include "vehicule.h"
#include "vehiculecontroller.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QGeoCoordinate>
simulation::simulation()
{

}
void simulation::remplir_vehicules(Point itineraires[100][24])
{
    Vehicule voiture;
    Point position;
    Point itineraire[24];
    for(int i=0; i<100;i++)
    {
        for(int j=0; j<24;j++)
        {
            itineraire[j]=itineraires[i][j];
        }
        position = *new Point(2,3);
        voiture= *new Vehicule(position);
        voiture.setPositionInfo(itineraire);
        d_vehicules[i]=voiture;
    }
}
void simulation::deplacement_vehicule()
{
    VehiculeController vehiculeCntrl;
    vehiculeCntrl.setCenter(QGeoCoordinate(47.732828,7.352456));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("VehiculeController", &vehiculeCntrl);
}
void simulation::start()
{
    Point itineraires[100][24];
//en fonction des routes
    remplir_vehicules(itineraires);

}
