//
//  CustomActionView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

enum SelectionKind: String {
    case planing = "В планах"
    case viewed = "Просмотрено"
}

// MARK: - CustomActionView

struct CustomActionView: View {
    @State private var selection: SelectionKind?

    var body: some View {
        ActionListView(
            choiceMade: $selection,
            selections: [
                SelectionKind.planing,
                SelectionKind.viewed
            ]
        )
    }
}


// MARK: - ActionListView

struct ActionListView<T: Hashable & RawRepresentable>: View where T.RawValue == String {
    @Binding var choiceMade: T?
    var selections: [T]

    var body: some View {
        VStack {
            Menu {
                ForEach(selections, id: \.self) { selection in
                    Button {
                        choiceMade = selection
                    } label: {
                        Text(selection.rawValue)
                    }
                }
            } label: {
                Label {
                    titleView
                } icon: {
                    Image(systemName: "chevron.down")
                }
            }
        }
        .font(Font.custom("Roboto", size: 12))
        .foregroundStyle(.white)
    }
}

// MARK: - UI Subviews

private extension ActionListView {
    @ViewBuilder
    var titleView: some View {
        if let choiceMade {
            Text("\(choiceMade.rawValue)")
        } else {
            Text("Добавить в")
        }
    }
}

// MARK: - Preview

#Preview {
    CustomActionView()
}
