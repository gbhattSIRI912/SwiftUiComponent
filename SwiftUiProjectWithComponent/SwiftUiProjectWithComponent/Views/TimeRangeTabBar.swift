//
//  TimeRangeTabBar.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 16/11/25.
//

import SwiftUI

enum TimeRange: String, CaseIterable, Identifiable {
    case day = "Day"
    case hour = "Hour"
    case week = "Week"
    case monthly = "Monthly"
    
    var id: String { rawValue }
}

struct TimeRangeTabBar: View {
    @Binding var selection: TimeRange
    
    private let cornerRadius: CGFloat = 10
    private let selectedBackground = Color(.systemGray5)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(TimeRange.allCases) { range in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selection = range
                    }
                } label: {
                    Text(range.rawValue)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(selection == range ? Color.primary : Color.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            Group {
                                if selection == range {
                                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                        .fill(selectedBackground)
                                } else {
                                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                        .fill(Color.clear)
                                }
                            }
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .accessibilityLabel("Time range")
    }
}

#Preview {
    
    StatefulPreviewWrapper(TimeRange.day) { selection in
        PreviewContainer(selection: selection)
            .padding()
    }
}

/// A tiny helper to preview views that require a Binding in Xcode previews.
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    let content: (Binding<Value>) -> Content
    
    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}

/// Preview-only container to demonstrate a horizontal tab that opens a bottom calendar
/// with a transparent backdrop and rounded (circular) corners.
private struct PreviewContainer: View {
    @Binding var selection: TimeRange
    @State private var isCalendarPresented = false
    @State private var selectedDate = Date()
    
    // Allow only dates up to today (no future dates)
    private var allowedDates: ClosedRange<Date> {
        let now = Date()
        let distantPast = Date.distantPast
        return distantPast...now
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                TimeRangeTabBar(selection: $selection)
                
                // The "tab" button with image + date text
                Button {
                    withAnimation(.easeInOut) {
                        isCalendarPresented = true
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.primary)
                        Text(formattedDate)
                            .foregroundStyle(.primary)
                            .font(.subheadline.weight(.semibold))
                        Spacer()
                        Image(systemName: "chevron.up")
                            .foregroundStyle(.secondary)
                            .imageScale(.small)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(.systemGray5))
                    )
                }
                .buttonStyle(.plain)
                
                Spacer(minLength: 0)
            }
            .zIndex(0)
            
            // Bottom calendar overlay
            if isCalendarPresented {
                ZStack(alignment: .bottom) {
                    // Transparent/dim backdrop
                    Color.black.opacity(0.25)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isCalendarPresented = false
                            }
                        }
                        .zIndex(1)
                    
                    // Bottom sheet with rounded (circular) corners
                    VStack(spacing: 12) {
                        // Grabber
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.secondary.opacity(0.5))
                            .frame(width: 36, height: 4)
                            .padding(.top, 8)
                        
                        DatePicker(
                            "Select a date",
                            selection: $selectedDate,
                            in: allowedDates,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                        // Auto-dismiss when the user selects a date
                        .onChange(of: selectedDate) { _ in
                            withAnimation(.easeInOut) {
                                isCalendarPresented = false
                            }
                        }
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                    .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: -2)
                    .padding(.horizontal, 0)
                    .padding(.bottom, 0)
                    .frame(maxWidth: .infinity)
                    .zIndex(2)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .ignoresSafeArea()
            }
        }
        .animation(.easeInOut, value: isCalendarPresented)
    }
}
