//
//  DetailView.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 16/11/25.
//

import SwiftUI

struct DetailView: View {
    let item: Item
    
    var body: some View {
        VStack(spacing: 12) {
            Text(item.title)
                .font(.largeTitle)
                .bold()
            Text(item.subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(item: .init(title: "", subtitle: ""))
}
