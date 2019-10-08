#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include <QQuickWindow>
//#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //Global RenderType settings（全局的RenderType设置）
    //对单个Text设置renderType: Text.NativeRendering比较烦
    //QQuickWindow::setTextRenderType(QQuickWindow::NativeTextRendering);

    //About MSVC Chinese characters（关于MSVC中文字符）
    //VS中使用utf8参考https://blog.csdn.net/xs1102/article/details/83186321
    //QtCreator中在Pro加utf8的设置（见本例pro文件msvc处）
    //设置参数后在使用时前面加上u8（MinGW不用加，加了也没影响）
    //qDebug()<<u8"中文";
    //测试在MSVC2017/2019下通过（包括VS和QtCreator）

    QGuiApplication app(argc, argv);


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
