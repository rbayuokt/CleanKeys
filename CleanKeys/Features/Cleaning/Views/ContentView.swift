//
//  ContentView.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI
import AppKit
import QuartzCore

struct ContentView: View {
    @Environment(\.colorScheme) private var scheme
    @StateObject var viewModel: CleaningViewModel

    private var isCleaning: Bool { viewModel.state == .cleaning }
    private var hasAX: Bool { viewModel.hasAccessibility }

    private struct LayoutKey: Equatable {
        let cleaning: Bool
        let hasAX: Bool
    }
    private var layoutKey: LayoutKey { LayoutKey(cleaning: isCleaning, hasAX: hasAX) }

    private var contentHeight: CGFloat { hasAX ? 340 : 460 }
    private let contentWidth: CGFloat = 640

    init(viewModel: CleaningViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: Spacing.lg) {
                HeaderView()
                    .padding(.bottom, Spacing.md)

                VStack(spacing: isCleaning ? Spacing.md : (Spacing.lg - 2)) {
                    StatusRow(isCleaning: isCleaning)

                    if !hasAX {
                        PermissionBanner(onRefresh: { viewModel.refreshPermission() })
                            .transition(.opacity)
                    }

                    Button(action: { viewModel.toggleCleaning() }) {
                        HStack(spacing: 10) {
                            Image(systemName: isCleaning ? "checkmark.circle.fill" : "keyboard")
                                .imageScale(.medium)
                            Text(isCleaning
                                 ? "Finish Cleaning & Re-enable Keyboard"
                                 : "Enable Cleaning Mode")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .lineLimit(1)
                                .minimumScaleFactor(0.94)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PrimaryButtonStyle(isDestructive: isCleaning, height: isCleaning ? 40 : 44))
                }
                .padding(Spacing.cardPadding)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .frame(maxWidth: 560)
                .animation(.easeInOut(duration: 0.22), value: layoutKey)

                TipsRow(isCleaning: isCleaning)
                Spacer(minLength: 0)
                FooterCredit(text: "Created by @rbayuokt")
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 22)
            .frame(width: contentWidth, height: contentHeight)
        }
        .onAppear {
            resizeAndLockWindow(to: NSSize(width: contentWidth, height: contentHeight))
        }
        .onChange(of: layoutKey) { _ in
            resizeAndLockWindow(to: NSSize(width: contentWidth, height: contentHeight))
        }
        .onDisappear { viewModel.finishCleaningIfActive() }
    }
}

// MARK: - Previews

#if DEBUG
#Preview("Default • Dark") {
    ContentView(viewModel: CleaningViewModel(blocker: KeyboardBlocker()))
        .previewLayout(.fixed(width: 640, height: 460))
        .preferredColorScheme(.dark)
}

#Preview("Default • Light") {
    ContentView(viewModel: CleaningViewModel(blocker: KeyboardBlocker()))
        .previewLayout(.fixed(width: 640, height: 460))
        .preferredColorScheme(.light)
}
#endif
