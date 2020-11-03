#ifndef ANTENNE_H
#define ANTENNE_H
#include <string>
#include "point.h"

class Antenne
{
    public:
        Antenne();
        Antenne(double x, double y, std::string nom, double puissance, double frequence, int rouge , int vert, int bleu);
        Point position();
        const std::string nom();
        double puissance();
        double frequence();
        int rouge();
        int vert();
        int bleu();
        void setNom(std::string nom);
        void setPuissance(double puissance);
        void setFrequence(double frequence);
        void setPosition(Point position);

    private:
        Point d_position;
        std::string d_nom;
        double d_frequence;
        double d_puissance;
        int d_rouge,d_vert,d_bleu;
};

#endif // ANTENNE_H
