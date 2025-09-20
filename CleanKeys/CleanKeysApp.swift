//
//  CleanKeysApp.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI
import AppKit

@main
struct CleanKeysApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CleaningViewModel(blocker: KeyboardBlocker()))
        }
        .defaultSize(width: 640, height: 460)
        .windowResizability(.contentSize)
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
            _ = AccessibilityHelper.ensureAccessibilityPermission()

            DispatchQueue.main.async {
                guard let window = NSApp.windows.first else { return }
                let size = NSSize(width: 640, height: 460)
                window.setContentSize(size)
                window.minSize = size
                window.maxSize = size
                window.styleMask.remove(.resizable)
                window.center()
                window.isMovableByWindowBackground = true
            }
        }
}



