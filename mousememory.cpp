#include "mousememory.h"

MouseMemory::MouseMemory(QObject *parent) : QObject(parent)
{

}

void MouseMemory::test()
{
    qDebug() << "Hello from the C++";
}

void MouseMemory::clear()
{
    qDebug() << "Clearing Data";
}

void MouseMemory::save()
{
    qDebug() << "Saving Data";
}

void MouseMemory::add(double x, double y)
{
    QPoint p(x,y);
    qDebug() << "Adding" << p;
}

void MouseMemory::add(QPointF point)
{
    qDebug() << "Adding Float" << point;
}
