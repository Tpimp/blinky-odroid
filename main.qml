import QtQuick 2.5
import QtQuick.Window 2.2

import com.embedded.io 1.0

Window { // The encapsulat
    visible: true
    visibility: Window.FullScreen
    width:1920
    height:1080

    MouseArea { // Mouse area to toggle LED manually
        anchors.fill: parent
        onClicked: {
            gpio200.value = !gpio200.value;
        }
    }

    QGpio{ // GPIO Object (commenicates with qgpio class in c++)
        id:gpio200
        number: "200";
        Component.onCompleted: {
            direction = QGpio.Out;
            edge = QGpio.Falling;
            active_low = false;
            value = false;
        }
    }


    Text { // Center Text
        text: qsTr("Blinky for Odroid")
        anchors.centerIn: parent
    }

    Rectangle{ // "Flasher Button" toggles LED flashing
       id: flasherButton
       color: "green"
       width: 150
       height: 150
       MouseArea{
           anchors.fill: parent
           onClicked:{
               if(!flasherTimer.running)
                   flasherTimer.start()
               else
                   flasherTimer.stop()
           }
       }
       Text{ //text on flasher button
           anchors.centerIn: parent
           font.pixelSize: parent.width/8
           text:"FLASHER"
       }
       anchors.left: parent.left
       anchors.top: parent.top
       anchors.margins: 150
    }
    Timer{ // a software timer with callback in 4 lines :)
        id: flasherTimer
        interval: 500
        repeat: true
        onTriggered: {
            gpio200.value = !gpio200.value
        }
    }

    Rectangle{ //create the exit button
        id: exitButton
        color:"red"
        width: 150
        height: 150
        MouseArea{
            anchors.fill: parent
            onClicked:{
                Qt.quit();
            }
        }
        Text{
            anchors.centerIn:  parent
            font.pixelSize: parent.width/8
            text:"EXIT"
        }
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 150
    }
}

