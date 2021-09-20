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
    var description: String {
        var display = ""
        display.append(self.ctrl ? "Ctrl-" : "")
        display.append(self.alt ? "Alt-" : "")
        display.append(self.cmd ? "Cmd-" : "")
        display.append(self.shift ? "shift-" : "")
        display.append(self.cap)
        return display
    }
}
