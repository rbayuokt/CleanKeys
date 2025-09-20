//
//  StatusRow.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI

struct StatusRow: View {
    let isCleaning: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(isCleaning ? Color.red : Color.green)
                .frame(width: 10, height: 10)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(isCleaning ? "Cleaning Mode is ON" : "Cleaning Mode is OFF")
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                Text(isCleaning ? "All keys are temporarily blocked."
                                : "Keyboard behaves normally.")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
            }
            Spacer(minLength: 0)
        }
    }
}

