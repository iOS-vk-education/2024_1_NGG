//
//  DownloadPageProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol DownloadPageInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapLogIn()
    func didTapRegister()
}
