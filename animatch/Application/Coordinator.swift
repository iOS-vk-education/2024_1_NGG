//
//  Coordinator.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import SwiftUI
import Foundation
import Observation

@Observable
final class Coordinator {
    var navPath = NavigationPath()
}

extension Coordinator {

    func addScreen<T: Hashable>(screen: T) {
        navPath.append(screen)
    }

    func openPreviousScreen() {
        guard navPath.count - 1 >= 0 else { return }
        navPath.removeLast()
    }

    func goToRoot() {
        while navPath.count > 0 {
            navPath.removeLast()
        }
    }
}
