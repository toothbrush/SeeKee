//
//  Keystroke.swift
//  SeeKee
//
//  Created by Paul on 20/9/21.
//

import Cocoa

struct Keystroke {
    var original_event: NSEvent
    var timestamp: Date = Date()
    var cap: String
    var ctrl: Bool = false
    var alt: Bool = false
    var cmd: Bool = false
    var shift: Bool = false
}

extension Keystroke: CustomStringConvertible {

    // More on that shifting logic..  Probably if any other modifiers are pressed, then we should show shift regardless? No.  See C-x # in Emacs.  Only if we have a special keykap should we show shift.
    var description: String {
        var display = ""
        display.append(self.cmd ? "Cmd-" : "")
        display.append(self.ctrl ? "Ctrl-" : "")
        display.append(self.alt ? "Alt-" : "")
        // TODO: we need fancier logic around whether we should display shift or not.  E.g., if it's "~" we should not display shift, but if it's an arrow key we probably should.
        display.append(self.shift && self.original_event.modifierFlags.contains(.function) ? "Shift-" : "")
        display.append(self.original_event.keyCap())
        return display
    }
}
