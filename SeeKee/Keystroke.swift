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
        // create and return a String that is how
        // you’d like a Store to look when printed
        return "foo"
    }
}
