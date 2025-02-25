//
//  AvatarView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 14.01.2025.
//

import SwiftUI

struct AvatarView: View {
    var image: UIImage?

    var body: some View {
        ZStack {
            if let userImage = image {
                Image(uiImage: userImage)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .clipped()
            } else {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.background)
                    .stroke(Color.textFieldGray, lineWidth: 2)
                    .frame(width: 150, height: 150)
            }
        }
    }
}
