//
//  NGGLogoView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct NGGLogoView: View {
    let title: String
    
    init(title: String = "Find, Watch, Repeat") {
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.logo)
                .resizable()
                .frame(width: 209, height: 69)
                .padding(.top, 250)
            
            Text(title)
                .foregroundColor(.downloadGray.opacity(0.6))
                .font(Font.custom("Roboto", size: 20))
        }
        .padding(.bottom, 139)
    }
}

// MARK: - Preview

#Preview {
    NGGLogoView(title: "title")
}
