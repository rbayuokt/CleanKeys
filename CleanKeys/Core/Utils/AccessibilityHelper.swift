//
//  AccessibilityHelper.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import ApplicationServices

enum AccessibilityHelper {
    @discardableResult
    static func ensureAccessibilityPermission() -> Bool {
        let opts: CFDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }

    static func isTrusted() -> Bool { AXIsProcessTrusted() }
}
