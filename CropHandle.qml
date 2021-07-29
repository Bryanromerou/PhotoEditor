import QtQuick 2.0

Item {
    id:root
    width: 20
    height: 6
    visible: false
    property var cropBorder: null
    property int rotation: 0
    property color handleColor: "white"
    property var dragableArea: null
    property double maximum: 10
    property double value:    0
    property double minimum:  0
    //property type name: value

    //onClicked:{root.value = value;  print('onClicked', value)}
    signal clicked(double value);
    signal activated(real xPosition, real yPosition)

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
            horizontalArea.drag.maximumY = dragableArea.width - root.width
            horizontalArea.drag.maximumX = dragableArea.height - root.width
            verticalArea.drag.maximumY = dragableArea.width - root.width
            verticalArea.drag.maximumX = dragableArea.height - root.width
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
                id:horizontalArea
                anchors.fill: parent
                drag.target: handle
                drag{
                    axis:Drag.XandYAxis
                    minimumY: 0
                    maximumY: dragableArea.height - root.width
                    minimumX: 0
                    maximumX: dragableArea.width - root.width
                }
                onPositionChanged: {
                    console.log(`${handle.x} , ${handle.y} `)
                    activated(handle.x,handle.y)
                }
            }
        }

        Rectangle{
            id: verticalBar
            color: handleColor
            height: root.width
            width: root.height
            MouseArea{
                id:verticalArea
                anchors.fill: parent
                drag.target: handle
                drag{
                    axis:Drag.XandYAxis
                    minimumY: 0
                    maximumY: dragableArea.height  - root.width
                    minimumX: 0
                    maximumX: dragableArea.width - root.width

                }
                onPositionChanged: {
                    console.log(`${handle.x} , ${handle.y} `)
                    activated(handle.x,handle.y)
                }
            }
        }
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
