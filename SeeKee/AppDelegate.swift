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
    @IBOutlet weak var backgroundBox: NSBox!

    var displayLabel: NSTextField!
    var keystrokes: [Keystroke] = []
    var inactivity: Timer?

    let MAX_KEYS = 3

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
            displayKeystrokes() // this one is superfluous, but i'm aiming to be able to have a didSet hook, so let's see that i don't introduce leaky things.
        }
    }

    func handler(event: NSEvent!) {
        pruneKeystrokes()
        let newKey = Keystroke(original_event: event,
                               cap: event.charactersIgnoringModifiers ?? event.keyCode.description,
                               ctrl: event.modifierFlags.contains(.control),
                               alt: event.modifierFlags.contains(.option),
                               cmd: event.modifierFlags.contains(.command),
                               shift: event.modifierFlags.contains(.shift))
        keystrokes.append(newKey)
        if keystrokes.count > MAX_KEYS {
            keystrokes = keystrokes.suffix(MAX_KEYS)
        }
        displayKeystrokes()
    }

    func pruneInactive() {
        // this should clear keystrokes if nothing has happened for a (longer) while
        if keystrokes.allSatisfy({ k in
            k.timestamp.distance(to: Date()) > 3.0 // seconds
        }) {
            keystrokes = []
            displayKeystrokes()
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window.level = .floating
        self.window.isMovableByWindowBackground = true
        self.backgroundBox.fillColor = NSColor.black
        self.backgroundBox.borderColor = NSColor.clear
        self.backgroundBox.alphaValue = 0.4
        self.backgroundBox.cornerRadius = 4

        let font = NSFont(name: "Monaco", size: 17)!
        displayLabel = NSTextField(labelWithAttributedString: NSAttributedString(string: "SeeKee", attributes: [.font: font]))
        displayLabel.frame = NSRect(x: 0,
                                    y: (self.window.frame.size.height - displayLabel.frame.size.height)/2,
                                    width: self.window.frame.size.width,
                                    height: displayLabel.frame.size.height)
        displayLabel.textColor = NSColor.cyan
        displayLabel.font = font
        displayLabel.alignment = .center

        self.window.contentView?.addSubview(displayLabel)

        self.window.setFrameAutosaveName("com.rustlingbroccoli.SeeKee.WindowFrame")

        inactivity = Timer.scheduledTimer(withTimeInterval: 0.1,
                                          repeats: true,
                                          block: { _ in
                                            self.pruneInactive()
                                          })

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

