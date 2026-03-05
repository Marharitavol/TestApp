//
//  ListSection.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import Foundation

nonisolated
struct ListSection: Hashable, Sendable {
    let type: SectionType
    var items: [PostItem]
}

nonisolated
enum SectionType: Hashable, Sendable {
    case main
}

nonisolated
struct PostItem: Hashable, Sendable {
    let postId: Int
    let title: String
    let previewText: String
    let likesCount: Int
    let timeAgo: String
    var isExpanded: Bool = false
}
