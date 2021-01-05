#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<hexagone.h>
#include<iostream>
#include <utils.h>
#include <QQuickStyle>
#include <QQmlComponent>

#include <QGeoCoordinate>

using namespace std;

vector<Hexagone> generateHexagones(int);
void sendHexagonesToQml(QObject* ,vector<Hexagone>);

int main(int argc, char *argv[]){

    const int numberOfHexagones = 20;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Material");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQmlComponent component(&engine, url);
    QObject *object = component.create();

    vector<Hexagone> listHexagones;

    listHexagones = generateHexagones(numberOfHexagones);

    sendHexagonesToQml(object, listHexagones);
    return app.exec();
}




std::vector<Hexagone> creerLigneHexagone(Point premierCentre, int nombre){
    std::vector<Hexagone> listHexagones;
    double marge = 0;
    Point centre = premierCentre;
    for (int i = 0; i < nombre; i++) {
        Hexagone hexagone;
        centre.setX(premierCentre.x() + marge);
        hexagone.setCentre(centre);
        hexagone.calculerSommets();

        listHexagones.push_back(hexagone);
        marge += hexagone.rayon() * sqrt(3);

    }

    return listHexagones;
}


std::vector<Hexagone> remplirPaire(Point premierCentre, int nombre){
    std::vector<Hexagone> listHexagonesPaires;

    listHexagonesPaires = creerLigneHexagone(premierCentre, nombre);
    return listHexagonesPaires;
}

std::vector<Hexagone> remplirImpaire(Hexagone premierHexagonePaire, int nombre){
    std::vector<Hexagone> listHexagonesImpaires;

    Point premierCentre = premierHexagonePaire.centre();
    double Y = premierCentre.y()-(premierHexagonePaire.rayon()*1.5);
    double X = premierCentre.x()+(premierHexagonePaire.rayon()*sqrt(3)/2);

    premierCentre.setX(X);
    premierCentre.setY(Y);

    listHexagonesImpaires = creerLigneHexagone(premierCentre, nombre);

    return listHexagonesImpaires;
}

vector<Hexagone> generateHexagones(int numberOfHexagones){

    vector<Hexagone> listHexagones;
    vector<Hexagone> listHexagonesImpaires;
    vector<Hexagone> listHeaxgonesPaires;

    //Remplir la premiere ligne des hexagones
    listHexagones = remplirPaire(Point(7.29573627960113, 47.76234132591956), numberOfHexagones);

    listHexagonesImpaires = remplirImpaire(listHexagones[0], numberOfHexagones);
    for (int i = 0; i < listHexagonesImpaires.size(); i++) {
        listHexagones.push_back(listHexagonesImpaires[i]);
    }
    for(int i=1 ;i<numberOfHexagones/2-5;i++) {
        Point premierPointPaire ;

        premierPointPaire.setX(listHexagones[0].centre().x());
        premierPointPaire.setY(listHexagones[0].centre().y()-(3*i*listHexagones[0].rayon()));
        remplirPaire(premierPointPaire, numberOfHexagones);
        remplirImpaire(remplirPaire(premierPointPaire, numberOfHexagones)[0], numberOfHexagones);

        for (int i = 0; i < remplirPaire(premierPointPaire, numberOfHexagones).size(); i++) {
            listHexagones.push_back(remplirPaire(premierPointPaire, numberOfHexagones)[i]);
            listHexagones.push_back(remplirImpaire(remplirPaire(premierPointPaire, numberOfHexagones)[0], numberOfHexagones)[i]);
        }

    }
    return listHexagones;
}

void sendHexagonesToQml(QObject* object,vector<Hexagone> listHexagones){

    QList<QGeoCoordinate> coordinateList;
    QVariantList listLongitude;
    QVariantList listLatitude;

    for (int i = 0; i < listHexagones.size(); i++) {
        std::vector<Point> sommets = listHexagones[i].sommets();
        int r = 0, g=255, b= 255;
        for (int i = 0; i < sommets.size(); i++){
            QGeoCoordinate coordinate;
            coordinate.setLatitude(sommets[i].y());
            coordinate.setLongitude(sommets[i].x());
            coordinateList.push_back(coordinate);

        }

        for(int i = 0 ; i < coordinateList.size(); i++){
            listLatitude.push_back(coordinateList[i].latitude());
            listLongitude.push_back(coordinateList[i].longitude());
        }

        QMetaObject::invokeMethod(object, "addHexagone",
                                  Q_ARG(QVariant, QVariant::fromValue(listLatitude)),
                                  Q_ARG(QVariant, QVariant::fromValue(listLongitude)),
                                  Q_ARG(QVariant, QVariant::fromValue(r)),
                                  Q_ARG(QVariant, QVariant::fromValue(g)),
                                  Q_ARG(QVariant, QVariant::fromValue(b)),
                                  Q_ARG(QVariant, QVariant::fromValue(listHexagones[i].centre().x())),
                                  Q_ARG(QVariant, QVariant::fromValue(listHexagones[i].centre().y())));
        listLongitude.clear();
        listLatitude.clear();
        coordinateList.clear();
    }
}

