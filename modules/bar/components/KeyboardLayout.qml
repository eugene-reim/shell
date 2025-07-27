import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland

Item {
    id: keyboardItem
    implicitWidth: layoutText.implicitWidth
    implicitHeight: layoutText.implicitHeight
    
    //Default string to show when shell started
    //Didnt find any ways to get it from system
    property string layout: "EN"
    property color colour
    
    Connections {
        target: Hyprland
        
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                updateLayoutFromEvent(event.data)
            }
        }
    }
    
    function transformLayout(layoutName) {
        if (layoutName.includes("Russian")) return "RU"
        if (layoutName.includes("English")) return "EN"
        return layoutName.substring(0, 2).toLowerCase()
    }
    
    function updateLayout(layoutName) {
        const newLayout = transformLayout(layoutName)
        if (newLayout !== keyboardItem.layout) {
            keyboardItem.layout = newLayout
        }
    }
    
    function updateLayoutFromEvent(eventData) {
        // Парсим данные события: activelayout,<keyboard>,<layout>
        const parts = eventData.split(',')
        if (parts.length > 1) {
            updateLayout(parts[1])
        }
    }
    
    Text {
        id: layoutText
        anchors.centerIn: parent
        text: parent.layout
        font.family: "FiraCode Nerd Font"
        font.pixelSize: 14
        color: parent.colour
        font.weight: Font.Medium
    }
}