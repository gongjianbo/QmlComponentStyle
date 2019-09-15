#ifndef COLORTOOL_H
#define COLORTOOL_H

#include <QObject>
#include <QColor>

class ColorTool : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
public:
    explicit ColorTool(QObject *parent = nullptr);

    Q_INVOKABLE double r() const;
    Q_INVOKABLE double g() const;
    Q_INVOKABLE double b() const;
    Q_INVOKABLE double h() const;
    Q_INVOKABLE double s() const;
    Q_INVOKABLE double l() const;
    Q_INVOKABLE double a() const;
    Q_INVOKABLE QColor adds(double value) const;
    Q_INVOKABLE QColor addl(double value) const;

    QColor getColor() const;
    void setColor(const QColor &c);

signals:
    void colorChanged();

private:
    QColor color;
};

#endif // COLORTOOL_H
