//
//  ContentView.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 16/11/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State
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
        NavigationStack(path: $navPath) {
            ZStack {
                listView
                
                if isMultiSelectMode && !selection.isEmpty {
                    bottomDeleteBar
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: selection)
                }
            }
            .navigationTitle("Items")
        }
    }
    
    // MARK: - Views
    
    private var listView: some View {
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
            .onDelete(perform: delete)
        }
        .listStyle(.insetGrouped)
        .navigationDestination(for: Item.self) { item in
            //DetailView(item: item)
            HeartRateAlertView()
        }
    }
    
    private func row(for item: Item) -> some View {
        HStack(spacing: 12) {
            if isMultiSelectMode {
                Image(systemName: selection.contains(item.id) ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selection.contains(item.id) ? Color.accentColor : Color.secondary)
                    .imageScale(.large)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
    }
    
    private var bottomDeleteBar: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Text("\(selection.count) selected")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Button(role: .destructive) {
                    withAnimation {
                        deleteSelected()
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding()
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    // MARK: - Actions
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
    
    private func delete(at offsets: IndexSet) {
        let idsToRemove = offsets.map { items[$0].id }
        items.remove(atOffsets: offsets)
        idsToRemove.forEach { selection.remove($0) }
        if selection.isEmpty {
            isMultiSelectMode = false
        }
    }
    
    private func deleteSelected() {
        guard !selection.isEmpty else { return }
        items.removeAll { selection.contains($0.id) }
        selection.removeAll()
        isMultiSelectMode = false
    }
    
    private func exitMultiSelect() {
        selection.removeAll()
        isMultiSelectMode = false
    }
}

#Preview {
    ContentView()
}
