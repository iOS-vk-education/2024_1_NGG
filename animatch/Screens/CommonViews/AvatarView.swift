//
//  AvatarView.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.01.2025.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.background)
            .stroke(Color.textFieldGray, lineWidth: 2)
            .frame(width: 150, height: 150)
    }
}
