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

    func handler(event: NSEvent!) {
        if event.keyCode == self.keycode
            && event.modifierFlags.contains(keymask) {
            print("PRESSED")
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let opts = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary

        guard AXIsProcessTrustedWithOptions(opts) == true
        else {
            print("scheisse")
            return
        }

        NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: self.handler)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

