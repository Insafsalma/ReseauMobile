#ifndef VEHICULECONTROLLER_H
#define VEHICULECONTROLLER_H
#include <QGeoCoordinate>
#include <QObject>
#include <QGeoCircle>

class VehiculeController:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoCoordinate center READ center NOTIFY centerChanged)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)
   public:
      VehiculeController(QObject *parent=0):QObject(parent){
        mCircle.setRadius(1000);
      }
       QGeoCoordinate center() const
       {
           return mCircle.center();
       }
       void setCenter(const QGeoCoordinate &center){
               if(mCircle.center() == center)
                   return;
               mCircle.setCenter(center);
               emit centerChanged();
           }
       void translate(double degreesLatitude, double degreesLongitude){
           mCircle.translate(degreesLatitude, degreesLongitude);
           emit centerChanged();
       }

       qreal radius() const{ return mCircle.radius();}
       void setRadius(const qreal &radius){
           if(mCircle.radius() == radius)
               return;
           mCircle.setRadius(radius);
           emit radiusChanged();
       }
   signals:
       void centerChanged();
       void radiusChanged();
   private:
       QGeoCircle mCircle;
};

#endif // VEHICULECONTROLLER_H
