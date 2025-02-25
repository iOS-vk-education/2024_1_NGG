//
//  NGGAdaptiveScrollView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.01.2025.
//

import SwiftUI

struct AdaptiveScrollView<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > geometry.size.height {
                ScrollView {
                    content()
                }
            } else {
                content()
            }
        }
    }
}
