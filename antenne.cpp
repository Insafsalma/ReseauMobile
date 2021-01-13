#include "antenne.h"
#include "Point.h"

Antenne::Antenne():d_position{Point(0,0)},d_nom{"null"},d_puissance{400},d_frequence{400}
{ }

Antenne::Antenne(double x, double y, std::string nom, double puissance, double frequence):
    d_position{Point(x,y)},
    d_nom {nom},
    d_puissance{puissance},
    d_frequence{frequence}
{}

const std::string Antenne::nom()
{
    return d_nom;
}
double Antenne::puissance()
{
    return d_puissance;
}
double Antenne::frequence()
{
    return d_frequence;
}


void Antenne::setNom(std::string nom){d_nom=nom;}
void Antenne::setPuissance(double puissance){d_puissance=puissance;}
void Antenne::setPosition(Point position){d_position=position;}
void Antenne::setFrequence(double frequence){d_frequence=frequence;}

Point Antenne::position(){
    return d_position;
};


