//
//  animatchApp.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.11.2024.
//

import SwiftUI

@main
struct animatchApp: App {
    var body: some Scene {
        WindowGroup {
            AnimeListView(viewModel: AnimeListViewModelMock(delay: 2))
        }
    }
}
