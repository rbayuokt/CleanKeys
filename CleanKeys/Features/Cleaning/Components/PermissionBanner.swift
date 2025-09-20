//
//  PermissionBanner.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI
import AppKit

struct PermissionBanner: View {
    var onRefresh: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "hand.raised.fill")
                .imageScale(.medium)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text("Accessibility permission required")
                    .font(.system(size: 12, weight: .semibold))

                Text("To block keys system-wide, allow access in System Settings → Privacy & Security → Accessibility.")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(3)
                    .minimumScaleFactor(0.95)

                HStack(spacing: 8) {
                    Button {
                        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        Label("Open Settings", systemImage: "arrow.turn.down.right")
                            .labelStyle(.titleAndIcon)
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    if let onRefresh {
                        Button("Refresh") { onRefresh() }
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .buttonStyle(.plain)
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(.yellow.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}


