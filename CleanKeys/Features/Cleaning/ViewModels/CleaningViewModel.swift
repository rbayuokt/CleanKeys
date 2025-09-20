//
//  CleaningViewModel.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import Foundation
import AppKit

final class CleaningViewModel: ObservableObject {
    @Published private(set) var state: CleaningState = .idle
    @Published private(set) var hasAccessibility: Bool = AccessibilityHelper.isTrusted()

    private let blocker: KeyboardBlocking
    private var timer: Timer?

    init(blocker: KeyboardBlocking = KeyboardBlocker()) {
        self.blocker = blocker
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.hasAccessibility = AccessibilityHelper.isTrusted()
        }
    }

    deinit {
        timer?.invalidate()
        blocker.disable()
    }

    private func ensurePermissionOrGuide() -> Bool {
        _ = AccessibilityHelper.ensureAccessibilityPermission()
        hasAccessibility = AccessibilityHelper.isTrusted()
        guard hasAccessibility else {
            if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
                NSWorkspace.shared.open(url)
            }
            NSSound.beep()
            NSApp.requestUserAttention(.informationalRequest)
            return false
        }
        return true
    }

    func refreshPermission() {
        hasAccessibility = AccessibilityHelper.isTrusted()
    }

    func toggleCleaning() {
        if !AccessibilityHelper.isTrusted() {
            guard ensurePermissionOrGuide() else { return }
        }
        switch state {
        case .idle:
            blocker.enable()
            state = .cleaning
        case .cleaning:
            blocker.disable()
            state = .idle
        }
    }

    func finishCleaningIfActive() {
        if state == .cleaning {
            blocker.disable()
            state = .idle
        }
    }
}



