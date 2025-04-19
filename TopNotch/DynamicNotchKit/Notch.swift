//
//  Notch.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//

import SwiftUI

struct NotchInfoPanelView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
                .imageScale(.large)

            VStack(alignment: .leading, spacing: 4) {
                Text("Hello from the Notch!")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("This is a floating panel.")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }

            Spacer()
        }
        .padding()
        .background(.black)
        .cornerRadius(20)
    }
}

