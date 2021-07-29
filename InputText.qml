import QtQuick 2.0

Item {
    id:root
    property int rotationAmount: 0
    property var control: null
    property bool drawMode: false
    property color xColor: "red"

    function deselectText(){
        textInput.focus = false
        focusChanged(textInput.focus)
    }
    function getMaxX(){
        if(rotationAmount%90 == 0 && rotationAmount%180 != 0 ){
            console.log("rotation is 90 or 270")
        }else{
            console.log("rotation is 0 , 180, or 360")
        }
    }
    signal focusChanged(bool focus);

    Rectangle{

        id:rootRectangle
        width:textInput.width + 15
        height:textInput.height + 15
        color: textInput.focus ?"#54C0B7FF":"transparent"
        anchors.margins: -5

        // Close button on text input
        Rectangle{
            visible: textInput.focus
            anchors.left: parent.right
            anchors.bottom: parent.top
            width: 16
            height: width
            radius: width/2
            anchors.leftMargin: -radius/2
            anchors.bottomMargin: -radius/2
            color:xColor
            Text{
                anchors.centerIn: parent
                font.pixelSize: 12
                text:"x"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    root.destroy()
                }
            }
        }


        // Need to add a check if Text is empty then remove it from workspace
        TextInput {
            rotation: -rotationAmount
            focus:true
            id:textInput
            color:"white"
            text: "Text"
            cursorVisible: false
        }

        MouseArea{
            visible: !drawMode
            id: rectangleArea
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAndYAxis
            drag.minimumX: root.control.x
            drag.maximumX: root.control.x + root.control.width - textInput.width
            drag.minimumY: root.control.y
            drag.maximumY: root.control.y + root.control.height - textInput.height

            onClicked: {
                textInput.focus = true
                focusChanged(textInput.focus)
            }
        }
    }
}
