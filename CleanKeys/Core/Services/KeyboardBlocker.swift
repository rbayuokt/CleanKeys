//
//  KeyboardBlocker.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import Cocoa
import ApplicationServices

final class KeyboardBlocker: KeyboardBlocking {
    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?

    private static func maskFor(_ type: CGEventType) -> CGEventMask { CGEventMask(1) << type.rawValue }
    private static let mask: CGEventMask =
        maskFor(.keyDown) | maskFor(.keyUp) | maskFor(.flagsChanged)

    private static let callback: CGEventTapCallBack = { _, type, event, refcon in
        guard let refcon = refcon else { return Unmanaged.passUnretained(event) }
        let blocker = Unmanaged<KeyboardBlocker>.fromOpaque(refcon).takeUnretainedValue()

        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            if let tap = blocker.eventTap { CGEvent.tapEnable(tap: tap, enable: true) }
            return nil
        }
        switch type {
        case .keyDown, .keyUp, .flagsChanged:
            return nil
        default:
            return Unmanaged.passUnretained(event)
        }
    }

    func enable() {
        guard eventTap == nil else { return }
        let refcon = Unmanaged.passUnretained(self).toOpaque()
        guard let tap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: Self.mask,
            callback: Self.callback,
            userInfo: refcon
        ) else { return }

        eventTap = tap
        runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        if let source = runLoopSource {
            CFRunLoopAddSource(CFRunLoopGetMain(), source, .commonModes)
        }
        CGEvent.tapEnable(tap: tap, enable: true)
    }

    func disable() {
        guard let tap = eventTap else { return }
        CGEvent.tapEnable(tap: tap, enable: false)
        if let source = runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetMain(), source, .commonModes)
        }
        runLoopSource = nil
        eventTap = nil
    }
}

