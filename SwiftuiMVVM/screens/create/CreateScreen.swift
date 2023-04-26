//
//  CreateScreen.swift
//  SwiftuiMVVM
//
//  Created by Bekhruz Hakmirzaev on 25/04/23.
//

import SwiftUI

struct CreateScreen: View {
    @ObservedObject var viewModel = CreateViewModel()
    @Environment(\.presentationMode) var presentation
    @State var titleText = ""
    @State var bodyText = ""
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 20){
                Text("Title").fontWeight(.medium)
                TextField("Title", text: $titleText)
                    .padding(10).background(.gray.opacity(0.15)).cornerRadius(10)
                Text("Body").fontWeight(.medium)
                TextField("Body", text: $bodyText)
                    .padding(10).background(.gray.opacity(0.15)).cornerRadius(10)
                Button(action: {
                    if titleText.count != 0 && bodyText.count != 0 {
                        viewModel.apiPostCreate(post: Post(title: titleText, body: bodyText), handler: { value in
                            if value {
                                self.presentation.wrappedValue.dismiss()
                            }
                        })
                    }
                }, label: {
                    HStack{
                        Spacer()
                        Text("Create").foregroundColor(.white)
                        Spacer()
                    }.padding(12).background(.blue).cornerRadius(10)
                })
                Spacer()
            }.padding(20)
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitle("Create Post", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left").foregroundColor(.white)
                .font(.system(size: 15))
        }))
        .toolbarBackground(
            .gray,
            for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct CreateScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateScreen()
    }
}
