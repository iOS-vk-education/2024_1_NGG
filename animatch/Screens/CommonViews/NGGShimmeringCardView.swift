//
//  NGGShimmeringCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 11.01.2025.
//

import SwiftUI

struct NGGShimmeringCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.cardGrey)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack() {
                NGGShimmeringView()
                    .frame(height: 28)
                HStack {
                    NGGShimmeringView()
                        .frame(width: 150)
                    Spacer()
                    NGGShimmeringView()
                        .frame(width: 100)
                }
                .frame(height: 14)
                .padding(.vertical, 10)
            }
            .padding(.vertical, 17)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Preview

#Preview {
    NGGShimmeringCardView()
}
