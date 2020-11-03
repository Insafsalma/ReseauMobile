#ifndef POINT_H
#define POINT_H


class Point
{
    public:
        Point();
        Point(double x, double y);
        double distance(const Point &p);
        double x();
        double y();
        void setX(double x);
        void setY(double y);
    private:
        double d_x;
        double d_y;
};

#endif // POINT_H
