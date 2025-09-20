//
//  TipsRow.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI

struct TipsRow: View {
    let isCleaning: Bool

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: isCleaning ? "sparkles" : "info.circle")
                .imageScale(.medium)
                .foregroundStyle(.secondary)

            Text(isCleaning
                 ? "Use your mouse/trackpad to click “Finish Cleaning” when done."
                 : "Tip: Enable Cleaning Mode before wiping keys to avoid accidental input.")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .minimumScaleFactor(0.9)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: 560)
    }
}

