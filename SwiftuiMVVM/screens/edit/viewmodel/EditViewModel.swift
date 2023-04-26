//
//  EditViewModel.swift
//  SwiftuiMVVM
//
//  Created by Bekhruz Hakmirzaev on 26/04/23.
//

import Foundation

class EditViewModel: ObservableObject {
    @Published var isLoading = false
    
    func apiPostEdit(post: Post, handler: @escaping (Bool) -> Void) {
        isLoading = true
        AFHttp.put(url: AFHttp.API_POST_UPDATE + (post.id)!, params: AFHttp.paramsPostCreate(post: post), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
