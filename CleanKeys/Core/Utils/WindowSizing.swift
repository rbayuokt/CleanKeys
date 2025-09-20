//
//  WindowSizing.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import AppKit
import QuartzCore

func resizeAndLockWindow(to contentSize: NSSize, animated: Bool = true) {
    guard let window = NSApp.keyWindow ?? NSApp.windows.first else { return }

    let targetContentRect = NSRect(origin: .zero, size: contentSize)
    let targetFrameSize = window.frameRect(forContentRect: targetContentRect).size

    var frame = window.frame
    frame.origin.y += (frame.size.height - targetFrameSize.height)
    frame.size = targetFrameSize

    window.styleMask.remove(.resizable)
    window.minSize = NSSize(width: contentSize.width, height: 100)
    window.maxSize = NSSize(width: contentSize.width, height: 2000)

    if animated {
        NSAnimationContext.runAnimationGroup { ctx in
            ctx.duration = 0.22
            ctx.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            window.animator().setFrame(frame, display: true)
        } completionHandler: {
            window.minSize = contentSize
            window.maxSize = contentSize
            window.styleMask.remove(.resizable)
        }
    } else {
        window.setFrame(frame, display: true)
        window.minSize = contentSize
        window.maxSize = contentSize
        window.styleMask.remove(.resizable)
    }
}

