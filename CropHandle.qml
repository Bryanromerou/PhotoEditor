import QtQuick 2.0

Item {
    id:root
    width: 20
    height: 6
    visible: false
    property var cropBorder: null
    property int rotation: 0
    property color handleColor: "red"

    property double maximum: 10
    property double value:    0
    property double minimum:  0
//    property /*type*/ name: value

    //onClicked:{root.value = value;  print('onClicked', value)}
    signal clicked(double value);

    // Corner Keys
    // Top-Right   : 0
    // Top-Left    : 1
    // Bottom-Right: 2
    // Bottom-Left : 3
    property int corner: 0 

    // This tranformation rotates the handle based on the rotation property
    transform: Rotation {origin.x:root.width/2; origin.y:root.height/2;  angle : rotation}

    // Since the handles do not sit right on the TR and BL we need to adjust the position slightly
    function adjust(){
        if(rotation ==90 || rotation ==270){
            horizontalBar.y = -root.height - 1
            horizontalBar.x = root.height
            verticalBar.y = -root.height - 1
            verticalBar.x = root.height
        }
    }

    Item{
        // Gave Id of Handle to move both rectangles(aka handle) at once
        id:handle

        Rectangle{
            id:horizontalBar
            Component.onCompleted: adjust()
            color: handleColor
            width: root.width
            height: root.height
            MouseArea{
                anchors.fill: parent
                drag.target: handle
            }
        }

        Rectangle{
            id: verticalBar
            color: handleColor
            height: root.width
            width: root.height
            MouseArea{
                anchors.fill: parent
                drag.target: handle
            }
        }
        // MouseArea {
        //     id: mouseArea
        //     anchors.fill: parent
        //     drag {
        //         target:   horizontalBar
        //         axis:     Drag.XAxis
        //         minimumX: 0
        //         maximumX: 1000
        //     }

        //     onPositionChanged:  if(drag.active) setPixels(dial.x + 0.5 * dial.width)
        //     onClicked:                          setPixels(mouse.x)
        // }
        // function setPixels(pixels) {
        //     // TotalWidth / (TotalWidth-dial.Width) * (argument-dial.width) + 0 (min)
        //     var value = (maximum - minimum) / (root.width - dial.width) * (pixels - dial.width / 2) + minimum
        //     // Send signal to root and passes the value onClick
        //     clicked(Math.min(Math.max(minimum, value), maximum))
        // }
    }

    //Added this function that will set the flag of which corner it is so that we can use the movement of that specific corner to adjust the cropping size
    Component.onCompleted: {
        if(rotation == 90){
            corner = 1 // Top Right
        }else if(rotation == 270){
            corner = 2 // Bottom Left
        }else if (rotation == 180){
            corner = 3 // Bottom Right
        }else{
            corner = 0 // Top Left
        }
    }
}
