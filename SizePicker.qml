import QtQuick 2.0

Item {
    id: root
    property var sizes: []
    property var choices: []
    property int max: 10

    function createChoices (size = 2, spacer = 0){
        var component = Qt.createComponent("Size.qml")
        choices.push(component.createObject(choiceHolder,{"x":spacer,"size":size,"holderSize":max,onClicked:console.log("hey")}))
    }

    Rectangle{
        id: choiceHolder
        color: "blue"
        width: max*10
        height: width/10
        Component.onCompleted: {
            sizes.forEach((size,i) =>{
                createChoices(size, i*10 + size*5)
            })
        }
    }
}
