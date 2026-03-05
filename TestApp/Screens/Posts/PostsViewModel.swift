//
//  PostsViewModel.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import Foundation

class PostsViewModel {
    
    var sections: [ListSection] = []
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPosts(completion: (() -> Void)?) {
        networkManager.getPosts { [weak self] response in
            guard let self else { return }
            sections = [.init(
                type: .main, items: response.posts.map {
                    PostItem(
                        postId: $0.postId,
                        title: $0.title ?? "",
                        previewText: $0.previewText ?? "",
                        likesCount: $0.likesCount ?? 0,
                        timeAgo: $0.timeAgo
                    )
                }
            )]
            completion?()
        }
    }
    
    func toggleExpansion(for section: Int, index: Int) {
        sections[section].items[index].isExpanded.toggle()
    }
}
