//
//  AnimeListView.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

struct AnimeListView: View {
    @State var viewModel = AnimeListViewModel()

    var body: some View {
        listContainer
            .frame(maxWidth: .infinity)
            .background(backgroundLineGradient)
            .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        AnimeListView(viewModel: .mockData)
    }
}
