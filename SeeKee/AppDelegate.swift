//
//  AppDelegate.swift
//  SeeKee
//
//  Created by Paul on 20/9/21.
//

import Cocoa
import Carbon

struct Keystroke {
    var original_event: NSEvent
    var timestamp: Date = Date()
    var cap: String
    var ctrl: Bool = false
    var alt: Bool = false
    var cmd: Bool = false
    var shift: Bool = false
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    let keycode = UInt16(kVK_ANSI_X)
    let keymask: NSEvent.ModifierFlags = [.command, .control]

    var keystrokes: [Keystroke] = []

    func handler(event: NSEvent!) {
        print("[event] ", event.charactersIgnoringModifiers)
        let newKey = Keystroke(original_event: event,
                               cap: String(format: "%d", event.keyCode),
                               ctrl: event.modifierFlags.contains(.control),
                               alt: event.modifierFlags.contains(.option),
                               cmd: event.modifierFlags.contains(.command),
                               shift: event.modifierFlags.contains(.shift))
        keystrokes.append(newKey)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let tr: CFBoolean = kCFBooleanTrue
        let opts = NSDictionary(object: tr,
                                forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString)
            as CFDictionary

        guard AXIsProcessTrustedWithOptions(opts) == true
        else {
            print("scheisse - please allow access and restart")
            return
        }

        NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: self.handler)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

