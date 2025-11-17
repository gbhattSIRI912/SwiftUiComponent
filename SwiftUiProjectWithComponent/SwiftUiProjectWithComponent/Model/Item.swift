//
//  Item.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 16/11/25.
//

import Foundation

// MARK: - Model
struct Item: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    
    init(id: UUID = UUID(), title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}
