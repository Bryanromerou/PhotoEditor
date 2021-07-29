import QtQuick 2.0

Item {
    id:root
    property int size: 2
    property int holderSize: 10

    signal clicked(int size)

    Rectangle{
        anchors.topMargin: -200
        y: holderSize/2
        color: "red"
        width: root.size
        height: root.size
        radius: width/2
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                console.log(`You chose the size: ${size}`)
                var numb = size
                clicked(numb)
            }

        }
    }
}
