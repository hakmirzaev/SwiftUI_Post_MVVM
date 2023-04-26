//
//  HomeScreen.swift
//  SwiftuiMVVM
//
//  Created by Bekhruz Hakmirzaev on 25/04/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingEdit = false
    
    func delete(indexSet: IndexSet) {
        let post = viewModel.posts[indexSet.first!]
        viewModel.apiPostDelete(post: post, handler: { value in
            if value {
                viewModel.apiPostList()
            }
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.posts, id: \.self) { post in
                        PostCell(post: post).onLongPressGesture{
                            self.viewModel.tempPost = post
                            self.showingEdit.toggle()
                        }.sheet(isPresented: $showingEdit, content: {
                            EditScreen(post: viewModel.tempPost)
                        })
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            
            .navigationBarItems(leading: Button(action: {
                viewModel.apiPostList()
            }, label: {
                Image("ic_refresh").resizable().foregroundColor(.white)
            }), trailing: NavigationLink(destination: CreateScreen(), label: {
                Image("ic_add").resizable().foregroundColor(.white)
            }))
            .navigationBarTitle("SwiftUI MVVM", displayMode: .inline)
            .toolbarBackground(
                .gray,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }.onAppear{
            viewModel.apiPostList()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
