//
//  CustomToolbarView.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 17/11/25.
//

import SwiftUI

struct CustomToolbarView: View {
    var backAction: () -> Void
    var deleteAction: () -> Void
    var body: some View {
        // Custom toolbar
        HStack {
            Button {
                backAction()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Button(role: .destructive) {
                deleteAction()
            } label: {
                Image(systemName: "trash")
                    .imageScale(.medium)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Delete")
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(.thinMaterial)
    }
}

#Preview {
    CustomToolbarView(backAction: {
        print("back Tapped")
    }, deleteAction: {
        print("Delete Tapped")
    })
}
