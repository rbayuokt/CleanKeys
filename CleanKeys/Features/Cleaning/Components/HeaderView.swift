//
//  HeaderView.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("CleanKeys")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .kerning(0.4)

            Text("Pause keys. Clean freely.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 440)
                .accessibilityLabel("Pause the keyboard so you can clean it freely.")
        }
    }
}

