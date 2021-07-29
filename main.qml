import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.0

// Things to implement:
// 1.) Crop
//      -- Crop button should enable "Crop Mode" ✅
//      -- In "Crop Mode" corner handles should appear ✅
//      -- Add "Done" button to get out of "Crop Mode" ✅
//      -- "Cropping" the image should allow to reset back to original state ✅
//      !!-- When moving the handles the "Crop Area" should change.
//      !!-- When clicking done, the Image should get cropped
// 2.) Rotate
//      -- Rotate button should rotate image 90 degrees ✅
//      -- Horizontal Flip button should flip image Horizontaly (Stretch Goal)
// 3.) Add Text
//      -- Add "Add Text" Button ✅
//      -- When clicking on "Add Text" Button a editable text field should pop up. ✅
//      -- The text field should be dragable anywhere on the picture. ✅
// 4.) Doodle Mode
//      -- Add "Doodle" Button that enables drawMode. ✅
//      -- Allow to Draw on Screen when drawMode is enabled. ✅
//      -- Once in drawMode a "Done" Button should appear. ✅
//      -- User should only be able to draw while drawMode is enabled. ✅
//      -- Only should be able to draw on Image and not outside of Image. ✅
//      -- When the Image gets rotated the drawing should get rotated as well. ✅
//      -- Should have "Undo" and "Redo" buttons ✅
//      !!-- Have Redo and Undo functionality working
//      !!-- Whatever is drawn should persist when download
//      a.) Markers
//          !-- Have preset widths to let user choose width of stroke
//          OR
//          !-- Should have a slider that changes the width of the stroke
//          AND
//          -- Should have some type of color picker ✅
// 5.) Save Button
//      -- Create Button that says "Save" ✅
//      !!-- Should allow user be able to download the current version of Image with doodle and crops

Window {
    id:root
    width: 375
    height: 812
    visible: true
    property int rotationAmount: 0
    property bool drawMode: false
    property bool cropMode: false
    property bool textMode: false
    property color drawColor: "blue"


    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            mainImage.source = decodeURIComponent(fileDialog.fileUrl);
            cropButton.visible = true
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    // Calling this function shall rotate "mainImage" based on the root's rotationsAmount which is being change on click of rotateButton
    function rotateImage(direction) {
        if (direction === "right") {
            mainImage.transform = rot
        }
    }
    Rotation{id : rot; origin.x : mainImage.width/2 ;origin.y : mainImage.height/2 ; angle : rotationAmount}

    Rectangle{
            id:videoContainer
            width : root.width
            height : root.height - 150
            // color: "black"

            CroppableImage {
                id: mainImage
                drawColor: root.drawColor
                cropMode: root.cropMode
                drawMode: root.drawMode
                anchors.centerIn: videoContainer
                rotationAmount: root.rotationAmount
                source: "file:///home/bryan/Pictures/butterfiy.jpeg"
            }

    }

    // CROP Button -- When clicked should enable cropMode
    Button{
        id: cropButton
        visible: !drawMode
        // visible: false -- Should only be visible if image is on screen
        text: cropMode ? "Done": "Crop Image"
        onClicked: {
            root.cropMode = !root.cropMode
        }
        anchors.top: videoContainer.bottom
        anchors.right: videoContainer.right
    }

    // RESET button -- When clicked the image should get returned to its original state
    Button{
        id: resetButton
        visible: !drawMode
        // visible: false -- Should only be visible if image is on screen
        text: "RESET"
        textColor:"red"
        onClicked: {
            console.log("Reseting Image to original state")
            rotationAmount = 0
            root.rotateImage("right")
        }
        anchors.horizontalCenter: videoContainer.horizontalCenter
    }

    // ROTATE Button -- When clicked the image should rotate 90 degrees
    Button{
        id: rotateButton
        visible: cropMode
        iconUrl: "/img/img/rotate.png"
        // visible: false -- Should only be visible if image is on screen
        x:20
        width: 40
        height: width
        anchors.top: videoContainer.bottom
        onClicked: {
            rotationAmount = rotationAmount + 90
            root.rotateImage("right")
        }
    }

    // ADD TEXT Button
    Button{
        id:textButton
        text: "Add text"
        visible: !drawMode && !cropMode
        anchors.top: videoContainer.bottom
        anchors.horizontalCenter: videoContainer.horizontalCenter
        onClicked: {
            mainImage.createTextInput()
        }
    }

    // DOODLE Button
    Button{
        id:drawButton
        visible: !cropMode
        anchors.horizontalCenter: videoContainer.horizontalCenter
        text: drawMode ? "Done": "Doodle"
        textColor: drawMode ? "green": "black"
        onClicked: {
            drawMode = !root.drawMode
        }
    }

    // CLEAR DRAWING Button
    Button{
        id:clearButton
        text: "CLEAR"
        bgColor: "red"
        textColor:"white"
        visible: drawMode
        onClicked: {
            mainImage.clearDrawing()
        }
    }

    // COLOR Picker Button
    Button{
        id: colorPickerButton
        visible:drawMode
        // visible: false -- Should only be visible if image is on screen
        text: "Pick Color"
        textColor: drawColor
        anchors.top: videoContainer.bottom
        anchors.right: videoContainer.right
        onClicked: {
            colorDialog.visible = true
        }
    }

    // Color Picker Dialog
    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            console.log("You chose: " + colorDialog.color)
            root.drawColor = colorDialog.color
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    // UNDO Button
    Button{
        id:undoButton
        anchors.left: drawButton.right
        iconUrl: "/img/img/undo-1.png"
        width: 50
        visible: drawMode && mainImage.undoEnabled
        onClicked: {
            console.log("Undoing")
            mainImage.undoDrawing()
        }
    }
    // REDO Button
    Button{
        id:redoButton
        x:20
        anchors.left: undoButton.right
        iconUrl: "/img/img/redo-1.png"
        width: 50
        visible: drawMode && mainImage.redoEnabled
        onClicked: {
            console.log("Redoing")
            mainImage.redoDrawing()
        }
    }


    // SAVE Image Button
    Button{
        id:saveButton
        text: "Save Copy"
        anchors.top: videoContainer.bottom
        anchors.topMargin: 100
        onClicked: {
            console.log("Saving copy of the Image")
        }
    }

//    SizePicker{
//        visible: drawMode
//        anchors.top: drawButton.bottom
//        anchors.horizontalCenter: drawButton.horizontalCenter
//        anchors.topMargin: 20
//        id:sizePicker
//        sizes: [10,14,18,22,26]
//        width: 300
//    }

    // FILE Button
    Button{
        id:fileButton
        text: "Select File"
        anchors.top: videoContainer.bottom
        anchors.horizontalCenter: videoContainer.horizontalCenter
        anchors.topMargin: 100
        onClicked: {
            console.log("This has been clicked making background black")
            videoContainer.color = "black"
            fileDialog.open();
        }
    }
}
