//
//  APIEndpoint.swift
//  TestApp
//
//  Created by Rita on 04.03.2026.
//

import Foundation

enum APIEndpoint {
    case posts
    case postDetail(id: String)
    
    private var baseUrl: URL {
        URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "main.json"
        case .postDetail(let id):
            return "posts/\(id).json"
        }
    }
    
    var url: URL {
        baseUrl.appendingPathComponent(path)
    }
}
