//
//  actionListView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ActionListView: View {
    @State var choiceMade = "Добавить в"

    var body: some View{
        VStack {
            Menu {
                Button(action: {
                    choiceMade = "В планах"
                }, label: {
                    Text("В планах")
                })
                Button(action: {
                    choiceMade = "Просмотрено"
                }, label:{
                    Text("Просмотрено")
                })
            } label: {
                Label(
                    title: {Text("\(choiceMade)")},
                    icon: {Image(systemName: "chevron.down")}
                )
            }
        }
        .font(Font.custom("Roboto", size: 12))
        .foregroundStyle(.white)
    }
}

// MARK: - Preview

#Preview{
    ActionListView().body.preferredColorScheme(.dark)
}
