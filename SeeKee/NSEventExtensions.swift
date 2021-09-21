//
//  NSEventExtensions.swift
//  SeeKee
//
//  Created by Paul on 20/9/21.
//

import Carbon
import Cocoa

extension NSEvent {
    func keyCap() -> String {
        switch Int(self.keyCode) {
            case kVK_Escape:
                return "Esc"
            case kVK_F1:
                return "F1"
            case kVK_F2:
                return "F2"
            case kVK_F3:
                return "F3"
            case kVK_F4:
                return "F4"
            case kVK_F5:
                return "F5"
            case kVK_F6:
                return "F6"
            case kVK_F7:
                return "F7"
            case kVK_F8:
                return "F8"
            case kVK_F9:
                return "F9"
            case kVK_F10:
                return "F10"
            case kVK_F11:
                return "F11"
            case kVK_F12:
                return "F12"
            case kVK_Delete:
                return "BkSPC"
            case kVK_ForwardDelete:
                return "DEL"
            case kVK_Tab:
                return "TAB"
            case kVK_Return:
                return "RET"
            case kVK_Space:
                return "SPC"
            case kVK_LeftArrow:
                return "Left"
            case kVK_RightArrow:
                return "Right"
            case kVK_UpArrow:
                return "Up"
            case kVK_DownArrow:
                return "Down"
            case kVK_Home:
                return "Home"
            case kVK_PageUp:
                return "PgUp"
            case kVK_PageDown:
                return "PgDn"
            case kVK_End:
                return "End"
            default:
                if let char = self.charactersIgnoringModifiers {
                    return char
                }
                return "??"
        }
    }
}
