//
//  AppDelegate.swift
//  SeeKee
//
//  Created by Paul on 20/9/21.
//

import Cocoa
import Carbon

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    let keycode = UInt16(kVK_ANSI_X)
    let keymask: NSEvent.ModifierFlags = [.command, .control]

    @IBOutlet weak var displayLabel: NSTextField!
    var keystrokes: [Keystroke] = []

    func displayKeystrokes() {
        // TODO nicer
        displayLabel.stringValue = keystrokes.map({ ks in
            ks.description
        }).joined(separator: " ")
    }

    func pruneKeystrokes() {
        if keystrokes.allSatisfy({ keystroke in
            keystroke.timestamp.distance(to: Date()) > 1.0 // seconds
        }) {
            keystrokes = []
        }
    }

    func handler(event: NSEvent!) {
        pruneKeystrokes()
        print("[event] ", event.charactersIgnoringModifiers ?? "*no character*")
        let newKey = Keystroke(original_event: event,
                               cap: String(format: "%d", event.keyCode),
                               ctrl: event.modifierFlags.contains(.control),
                               alt: event.modifierFlags.contains(.option),
                               cmd: event.modifierFlags.contains(.command),
                               shift: event.modifierFlags.contains(.shift))
        keystrokes.append(newKey)
        displayKeystrokes()
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

