//@ pragma IconTheme Reversal
//@ pragma UseQApplication
import QtQuick
import Quickshell
import qs.components 
import qs.modules
import qs.bars


Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        required property var modelData

        LeftBar { modelData: scope.modelData }
        TopBar { modelData: scope.modelData }
    }
}