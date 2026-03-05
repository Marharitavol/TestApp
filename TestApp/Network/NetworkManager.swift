//
//  NetworkManager.swift
//  TestApp
//
//  Created by Rita on 04.03.2026.
//

import Foundation

protocol NetworkManagerProtocol {
    func getPosts(completion: @escaping (_ response: PostsResponce) -> Void)
    func getPost(by id: String, completion: @escaping (_ response: PostDetailResponse) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func getPosts(completion: @escaping (_ response: PostsResponce) -> Void) {
        request(endpoint: .posts, completion: completion)
    }
    
    func getPost(by id: String, completion: @escaping (_ response: PostDetailResponse) -> Void) {
        request(endpoint: .postDetail(id: id), completion: completion)
    }
    
    private func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (T) -> Void) {
        let request = URLRequest(url: endpoint.url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
