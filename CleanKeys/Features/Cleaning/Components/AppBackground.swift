//
//  AppBackground.swift
//  CleanKeys
//
//  Created by Rizky Bayu Oktavian on 20/09/25.
//

import SwiftUI

struct AppBackground: View {
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        Group {
            scheme == .dark
            ? Color.white.opacity(0.06)
            : Color.white.opacity(0.02)
        }
        .ignoresSafeArea()
    }
}

