//
//   DownloadWithProfileProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol DownloadWithProfileInput {
    func setCoordinator(_ coordinator: Coordinator)
    func didTapContinue(to screen: AppScreens)
}
