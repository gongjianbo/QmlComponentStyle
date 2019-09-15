#include "ColorTool.h"

#include <QDebug>

ColorTool::ColorTool(QObject *parent) : QObject(parent)
{

}

double ColorTool::r() const
{
    return color.redF();
}

double ColorTool::g() const
{
    return color.greenF();
}

double ColorTool::b() const
{
   return color.blueF();
}

double ColorTool::h() const
{
    return color.hueF();
}

double ColorTool::s() const
{
    return color.saturationF();
}

double ColorTool::l() const
{
    return color.lightnessF();
}

double ColorTool::a() const
{
    return color.alphaF();
}

QColor ColorTool::adds(double value) const
{
    QColor c;
    if(s()+value>1.0){
        c=QColor::fromHslF(h(),1.0,l(),a());
    }else if(s()+value<0.0){
        c=QColor::fromHslF(h(),0.0,l(),a());
    }else{
        c=QColor::fromHslF(h(),s(),l(),a());
    }
    return c;
}

QColor ColorTool::addl(double value) const
{
    QColor c;
    if(l()+value>1.0){
        c=QColor::fromHslF(h(),s(),1.0,a());
    }else if(l()+value<0.0){
        c=QColor::fromHslF(h(),s(),0.0,a());
    }else{
        c=QColor::fromHslF(h(),s(),l(),a());
    }
    return c;
}

QColor ColorTool::getColor() const
{
    return color;
}

void ColorTool::setColor(const QColor &c)
{
    color=c;
    emit colorChanged();
}
