#ifndef MOUSEMEMORY_H
#define MOUSEMEMORY_H

//#include <vector>
#include <QObject>
#include <QDebug>
#include <QPoint>

class MouseMemory : public QObject
{
    Q_OBJECT
private:
public:
    explicit MouseMemory(QObject *parent = nullptr);
    QVector <QPoint> arrOfPoints;
    QPoint myPoint;
    Q_INVOKABLE void test();
    Q_INVOKABLE void clear();
    Q_INVOKABLE void save();
    Q_INVOKABLE void add(double x, double y);
    Q_INVOKABLE void add(QPointF point);
signals:

};

#endif // MOUSEMEMORY_H
