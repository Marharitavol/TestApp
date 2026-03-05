//
//  DetailViewModel.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import Foundation

class DetailViewModel {
    
    private let networkManager: NetworkManagerProtocol
    private let postId: Int

    init(postId: Int, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.postId = postId
        self.networkManager = networkManager
    }

    func fetchPostDetails(completion: ((Post) -> Void)?) {
        networkManager.getPost(by: "\(postId)") { response in
            completion?(response.post)
        }
    }
}
