#include <QGuiApplication>
#include <QQmlApplicationEngine>
// QT += quickcontrols2
// #include <QQuickStyle>
// #include <QQuickWindow>
// #include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Global RenderType settings（全局的RenderType设置）
    // 使用NativeTextRendering和QPainter绘制效果差不多，QtTextRendering有抗锯齿低分屏没那么清晰
    // 对单个Text设置renderType: Text.NativeRendering比较麻烦
    // QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);

    // About MSVC Chinese characters（关于MSVC中文字符）
    // 测试：https://blog.csdn.net/gongjianbo1992/article/details/104078327
    // qDebug() << "中文测试";

    QGuiApplication app(argc, argv);
    // 可以修改QtQuick.Controls组件库的默认样式，但是比较简陋，可以用到一些对UI要求不高的场景
    // QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;   
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
