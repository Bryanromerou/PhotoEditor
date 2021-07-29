import QtQuick 2.0

Item {
    id: root

    // public
    property color dialColor: "black"
    property double dialSize: 5
    property double maximum: 10
    property double value:    0
    property double minimum:  0

    //onClicked:{root.value = value;  print('onClicked', value)}
    signal clicked(double value);

    // private
    width: 500;  height: dialSize // default size
    opacity: enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state

    // left and right trays (so tray doesn't shine through dial in disabled state)
    Repeater {
        model: 2
        delegate: Rectangle {
            x:     !index?               0: dial.x + dial.width - radius
            width: !index? dial.x + radius: root.width - x;  height: 0.2 * dial.height
            radius: 0.5 * height
            color: !index? dialColor: "#66000000"
            y: dial.height/2 - height/2
        }
    }

    // dial
    Rectangle {
        id: dial
        color: dialColor
        x: (value - minimum) / (maximum - minimum) * (root.width - dial.width)
        width: dialSize;  height: width
        border.width: 0.05 * root.height
        radius: 0.5 * height
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag {
            target:   dial
            axis:     Drag.XAxis
            maximumX: root.width - dial.width
            minimumX: 0
        }

        onPositionChanged:  if(drag.active) setPixels(dial.x + 0.5 * dial.width)
        onClicked:                          setPixels(mouse.x)
    }

    function setPixels(pixels) {
        // TotalWidth / (TotalWidth-dial.Width) * (argument-dial.width) + 0 (min)
        var value = (maximum - minimum) / (root.width - dial.width) * (pixels - dial.width / 2) + minimum
        // Send signal to root and passes the value onClick
        clicked(Math.min(Math.max(minimum, value), maximum))
    }
}
