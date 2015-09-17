#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "qgpio/qgpio.h"
#include <QtQml>
#include "qgpio/qgpiowatcher.h"

int QGpioWatcher::THREAD_SLEEP_TIME = 30;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<QGpio>("com.embedded.io",1,0,"QGpio");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

