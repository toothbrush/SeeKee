//
//  RBTransparentWindow.swift
//  TimerWidget
//
//  Created by paul david on 19/7/21.
//

import Cocoa

class RBTransparentWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: .borderless, backing: .buffered, defer: false)
        
        self.alphaValue = 1.0
        self.backgroundColor = NSColor.clear
        self.isOpaque = false
    }
}
