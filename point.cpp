#include "point.h"
#include<cmath>

Point::Point():d_x(0), d_y(0){}
Point::Point(double x, double y):d_x(x), d_y(y){}

double Point::distance(const Point& p)
{
    double dx= p.d_x-d_x;
    double dy=p.d_y-d_y;
    return std::sqrt(dx*dx +dy*dy);
}

double Point::x(){
    return d_x;
}
double Point::y(){
    return d_y;
}
void Point::setX(double x)
{
    d_x=x;
}
void Point::setY(double y)
{
    d_y=y;
}

