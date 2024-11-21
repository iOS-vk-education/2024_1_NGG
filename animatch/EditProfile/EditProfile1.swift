//
//  EditProfile1.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI



struct EditProfile1: View {
    var body: some View {
        VStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.editProfLightGrad, .editProfDarkGrad]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
             
                VStack(spacing: 0){
                    
                    Head()
                    
                    Spacer()
                    
                    Forms()
                    
                    //у полей ввода нижние паддинги 30
                        .padding(.bottom, 124)
                    VStack(spacing: 0){
                        
                        ZStack{
                            CustomButton(placeholder: "Сохранить и продолжить")
                        }
                        .padding(.bottom, 8)
                        
                        Button(action: {
                            print("Сделать позже")
                        }) {
                            Text("Сделать позже")
                                .underline()
                                .foregroundColor(.editProfPurple)
                        }
                    }.padding(.bottom, 64)
                    
                }.ignoresSafeArea()
                
            }
        }
        
    }
}

struct Head: View{
    var body: some View{
        ZStack(alignment: .top){
                
            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 24,bottomTrailing: 24))
                .fill(Color.editProfPurple)
                .frame(height: 166)
            
                Text("Профиль")
                    .foregroundStyle(.editProfWhite)
                    .font(Font.custom("Roboto", size: 20))
                    .offset(y:55)
                    .padding(.horizontal, 16)

            ZStack(alignment: .top){
                Avatar()
            }.offset(y: 123)

        }.ignoresSafeArea()
    }
}

struct PurpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 272, height: 51)
            .background(Color.editProfPurple)
            .foregroundStyle(Color.editProfWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CustomButton: View {
    var placeholder: String
    
    var body: some View {
        Button(placeholder) {
            print("Продолжить")
        }
        .buttonStyle(PurpleButton())
    }
}

struct InfoField: View {
    let title: String
    @Binding var text: String
    @FocusState private var isTyping: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            
            TextField("", text: $text)
                .padding(.leading, 16)
                .frame(width: 272, height: 51)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.editProfGray))
                .focused($isTyping)
            
            if text.isEmpty {
                Text(title)
                    .padding(.horizontal, 16)
                    .foregroundColor(Color.editProfGrayLight)
            }
        }.padding(.bottom, 30)
    }
}

struct CustomTextField: View {
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.editProfGray)
                .frame(width: 272, height: 51)
            Text(placeholder)
                .foregroundStyle(.editProfGrayLight)
                .padding(.leading, 16)
        }
        .padding(.bottom, 30)
    }
}


struct Forms: View {
    
    @State var Fname: String = ""
    @State var Lname: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            Text("Добавьте имя и фамилию")
                .foregroundStyle(Color.editProfWhite)
                .font(Font.custom("Roboto", size: 20))
                .padding(.bottom, 20)
            
            InfoField(title: "Имя", text: $Fname)
            InfoField(title: "Фамилия", text: $Lname)
            InfoField(title: "pochta@pochta.com", text: $email)
        }
    }
}


extension View {
    func addPlus(width: CGFloat, height: CGFloat) -> some View {
        ZStack(alignment: .bottomTrailing) {
            self
            
            Button(action: {
                print("Добавить аватар")
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .foregroundStyle(.editProfWhite)
                    .frame(width: width, height: height)
            }
        }
    }
}

struct Avatar: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.editProfGray)
            .frame(width: 150, height: 150)
            .addPlus(width: 24, height: 24)
    }
}

#Preview {
    EditProfile1()
}



