import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.0

ApplicationWindow {
    title: qsTr("Hello World")
    visibility: "FullScreen"
    width: 640
    height: 480
    id: window

    property var time_test_rectangle_created: -1
    property var summed_time_to_press: 0
    property var shown_elements: 0
    property var num_runs: 10

    Item
    {
        focus: true
        Keys.onPressed:
        {
            if (element_timer.running && event.key == Qt.Key_Space)
            {
                if (window.time_test_rectangle_created != -1)
                {
                    var time_difference = Date.now() - window.time_test_rectangle_created
                    window.summed_time_to_press += time_difference
                    window.time_test_rectangle_created = -1
                    test_rectangle.width = 0
                    test_rectangle.height = 0
                }
                else
                {
                    window.color = "red"
                    window.summed_time_to_press += 2000
                }

                if (window.shown_elements == num_runs)
                {
                    element_timer.stop()
                    test_rectangle.width = 0
                    test_rectangle.height = 0
                    result.text = "Durchschnittliche Reaktionszeit: " + window.summed_time_to_press / num_runs
                    window.color = "green"
                    start_button.visible = true
                    result.visible = true
                    window.shown_elements = 0
                }
            }
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Button {
        id: start_button
        text: qsTr("Starte Test")
        anchors.baseline: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked:
        {
            start_button.visible = false
            window.color = "white"
            element_timer.start()
            window.summed_time_to_press = 0
            window.time_test_rectangle_created = -1
            result.visible = false
        }
    }

    Item {
        Timer {
            interval: Math.random() * 5000 + 500;
            running: false;
            repeat: true
            id: element_timer
            onTriggered: {
                if (window.shown_elements < num_runs)
                {
                    test_rectangle.x = Math.random() * window.width;
                    test_rectangle.y = Math.random(window.height) * window.height;
                    test_rectangle.width = 30//Math.random() * 20.0 + 20
                    test_rectangle.height = 30//Math.random() * 20.0 + 20
                    test_rectangle.color = "gray" //Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                    window.time_test_rectangle_created = Date.now()
                    window.shown_elements += 1
                }
            }
        }
    }

    Text
    {
        id: result
        font.family: "Helvetica";
        font.pointSize: 20;
        font.bold: true
        text: "#"
        visible: false
        x: window.width / 2 - width/2
        y: window.height / 2 - height/2
    }

    Rectangle {
        x: 0
        y: 0
        width: 0
        height: 0
        color: "black"
        radius: 4
        border.color: "black"
        border.width: 2
        id: test_rectangle
    }
}
