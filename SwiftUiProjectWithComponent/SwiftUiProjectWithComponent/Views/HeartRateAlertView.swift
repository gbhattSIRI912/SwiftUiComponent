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
    @State private var items: [HeartRateDto] = [
        .init(dataUuid: "", deviceUuid: "", comment: "", startTime: 0, endTime: 0, updateTime: 0, timeOffset: 0, min: 95, max: 65, heartRate: 65, average: 65, binningData: .init(), alertHeartRate: false),
        .init(dataUuid: "", deviceUuid: "", comment: "", startTime: 0, endTime: 0, updateTime: 0, timeOffset: 0, min: 95, max: 65, heartRate: 65, average: 65, binningData: .init(), alertHeartRate: false),
        .init(dataUuid: "", deviceUuid: "", comment: "", startTime: 0, endTime: 0, updateTime: 0, timeOffset: 0, min: 95, max: 65, heartRate: 65, average: 65, binningData: .init(), alertHeartRate: false),
        .init(dataUuid: "", deviceUuid: "", comment: "", startTime: 0, endTime: 0, updateTime: 0, timeOffset: 0, min: 95, max: 65, heartRate: 65, average: 65, binningData: .init(), alertHeartRate: false)
    ]
    
    @State private var selection = Set<Item.ID>()
    @State private var isMultiSelectMode = false
    @State private var navPath = NavigationPath()
    @State private var isNavigateDetail: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            CustomToolbarView(backAction: {
                dismiss()
            }, deleteAction: {
                showDeleteAlert.toggle()
            })
            
            SummaryHStackView()
            
            List {
                ForEach(items.indices, id: \.self) { item in
                    row(for: items[item])
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isMultiSelectMode {
                                toggleSelection(for: items[item])
                            } else {
                                print(">>>>\(items[item])")
                                isNavigateDetail = true
                                
                                navPath.append(item)
                            }
                           
                        }
                        .onLongPressGesture(minimumDuration: 0.35) {
                            withAnimation {
                                if !isMultiSelectMode {
                                    isMultiSelectMode = true
                                }
                                toggleSelection(for: items[item])
                            }
                        }
                }
            }
        }
        .background(.thinMaterial)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isNavigateDetail, destination: {
           // DetailView(item: heartRateData!)
            DetailView(item: <#T##HeartRateDto#>)
        })
        .alert("Delete item?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                print("Deleted")
            }
        } message: {
            Text("This action cannot be undone.")
        }
    }
    
    private func row(for item: HeartRateDto) -> some View {
        HStack(spacing: 12) {
            if isMultiSelectMode {
                Image(systemName: selection.contains(item.id) ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selection.contains(item.id) ? Color.accentColor : Color.secondary)
                    .imageScale(.large)
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(item.min)-\(item.max)bpm")
                        .font(.headline)
                    Text("\(item.startTime)- \(item.endTime) PM")
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
    
    
    private func toggleSelection(for item: HeartRateDto) {
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
