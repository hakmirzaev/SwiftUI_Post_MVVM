//
//  EditScreen.swift
//  SwiftuiMVVM
//
//  Created by Bekhruz Hakmirzaev on 25/04/23.
//

import SwiftUI

struct EditScreen: View {
    @ObservedObject var viewModel = EditViewModel()
    @Environment(\.presentationMode) var presentation
    var post: Post
    @State var titleText = ""
    @State var bodyText = ""
    
    var body: some View {
        NavigationView{
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
                            viewModel.apiPostEdit(post: Post(id: post.id!, title: titleText, body: bodyText), handler: { value in
                                if value {
                                    self.presentation.wrappedValue.dismiss()
                                }
                            })
                        }
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Edit").foregroundColor(.white)
                            Spacer()
                        }.padding(12).background(.blue).cornerRadius(10)
                    })
                    Spacer()
                }.padding(20)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Edit Post", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(
                .gray,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.onAppear{
            titleText = post.title!
            bodyText = post.body!
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(post: Post(title: "", body: ""))
    }
}
