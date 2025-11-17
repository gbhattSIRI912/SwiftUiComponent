//
//  HeartRateAlertView.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 17/11/25.
//

import SwiftUI

struct HeartRateAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteAlert = false
    @State private var items: [Item] = [
        .init(title: "Alpha", subtitle: "First item"),
        .init(title: "Beta", subtitle: "Second item"),
        .init(title: "Gamma", subtitle: "Third item"),
        .init(title: "Delta", subtitle: "Fourth item"),
        .init(title: "Epsilon", subtitle: "Fifth item")
    ]
    
    @State private var selection = Set<Item.ID>()
    @State private var isMultiSelectMode = false
    @State private var navPath = NavigationPath()

    
    var body: some View {
        VStack(spacing: 0) {
            CustomToolbarView(backAction: {
                dismiss()
            }, deleteAction: {
                showDeleteAlert.toggle()
            })
            
            // You can also reuse SummaryHStackView here:
            SummaryHStackView()
            
            List {
                ForEach(items) { item in
                    row(for: item)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isMultiSelectMode {
                                toggleSelection(for: item)
                            } else {
                                navPath.append(item)
                            }
                        }
                        .onLongPressGesture(minimumDuration: 0.35) {
                            withAnimation {
                                if !isMultiSelectMode {
                                    isMultiSelectMode = true
                                }
                                toggleSelection(for: item)
                            }
                        }
                }
            }
        }
        .background(.thinMaterial)
        .navigationBarBackButtonHidden(true)
        .alert("Delete item?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                print("Deleted")
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
    
    private func row(for item: Item) -> some View {
        HStack(spacing: 12) {
            if isMultiSelectMode {
                Image(systemName: selection.contains(item.id) ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selection.contains(item.id) ? Color.accentColor : Color.secondary)
                    .imageScale(.large)
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "moon")
                    .foregroundStyle(Color.secondary)
                    .imageScale(.large)
            }
           
            Spacer()
        }
        .padding(.vertical, 6)
    }
    
    
    private func toggleSelection(for item: Item) {
        if selection.contains(item.id) {
            selection.remove(item.id)
        } else {
            selection.insert(item.id)
        }
        
        if selection.isEmpty {
            withAnimation {
                isMultiSelectMode = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        HeartRateAlertView()
    }
}

