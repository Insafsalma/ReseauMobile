#ifndef HEXAGONE_H
#define HEXAGONE_H
#include<vector>
#include "antenne.h"
#include "vehicule.h"

class Hexagone
{
    public:
        Hexagone();
        Point centre();
        double rayon();
        std::vector <Antenne*> antennes();
         std::vector <Vehicule*> vehicules();
        std::vector<Point> sommets();
        void setCentre(Point centre);
        void setRayon(double rayon);
        void ajouterAntenne(Antenne *a);
        void supprimerAntenne(Antenne *a);
        void ajouterVehicule(Vehicule *a);
//        void supprimerVehicule(Antenne *a);

        void calculerSommets();
        Point calculeSommet1();
        Point calculeSommet2();
        Point calculeSommet3();
        Point calculeSommet4();
        Point calculeSommet5();
        Point calculeSommet6();
        void afficherSommets();
        bool contientPoint(Point p);

    private:
        Point d_centre;
        double d_rayon;
        std::vector <Point> d_sommets;
        std::vector <Antenne*> d_antennes;
        std::vector <Vehicule*> d_vehicules;
};

#endif // HEXAGONE_H
