//
//  DetailView.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 16/11/25.
//

import SwiftUI

struct DetailView: View {
    var item: HeartRateDto
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(item.min)")
                .font(.largeTitle)
                .bold()
            Text("\(item.max)")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
