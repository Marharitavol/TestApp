//
//  Model.swift
//  TestApp
//
//  Created by Rita on 04.03.2026.
//

import Foundation

struct PostsResponce: Decodable {
    let posts: [Post]
}

struct Post: Decodable {
    let postId: Int
    let timestamp: Int?
    let title: String?
    let text: String?
    let postImage: String?
    let previewText: String?
    let likesCount: Int?
    
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timestamp = "timeshamp"
        case title
        case text
        case postImage
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
    
    var timeAgo: String {
        guard let timestamp else { return "" }
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    var formattedDate: String {
        guard let timestamp else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}

struct PostDetailResponse: Decodable {
    let post: Post
}
