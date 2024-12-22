//
//  DirectorsModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import Foundation

struct Directors: Identifiable {
    let id = UUID()
    let name: String
    var isSelected: Bool
}
