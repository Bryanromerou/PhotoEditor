import QtQuick 2.0

Item {
    id: root
    height: 40
    width: 100
    property string text
    property url iconUrl
    property color bgColor: "white"
    property color bgColorSelected: "#bdbdbd"
    property color textColor: "black"
    property color textColorSelected: "white"
    property alias enabled: mouseArea.enabled
    property alias radius: bgr.radius
    property color borderColor: "black"

    signal clicked


    Rectangle {
        id: bgr
        anchors.fill: parent
        color: mouseArea.pressed ? bgColorSelected : bgColor
        radius: height / 15
        border.color: borderColor
        border.width: 1

        Text {
            id: text
            anchors.centerIn: parent
            text: root.text
            font.pixelSize: 0.4 * parent.height
            color: mouseArea.pressed ? textColorSelected : textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Image{
            source: iconUrl
            anchors.fill: parent
            scale: .8
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
