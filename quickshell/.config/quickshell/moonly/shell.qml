//@ pragma IconTheme Reversal
//@ pragma UseQApplication
import QtQuick
import Quickshell
import qs.components 
import qs.modules
import qs.bars


ShellRoot {

    Variants {
        model: Quickshell.screens
        TopBar {}
    }

    Variants {
        model: Quickshell.screens
        LeftBar {}
    }
}