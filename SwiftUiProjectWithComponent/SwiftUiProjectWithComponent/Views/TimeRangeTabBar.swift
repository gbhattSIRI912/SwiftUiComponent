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
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Time range")
    }
}

#Preview {
    StatefulPreviewWrapper(TimeRange.day) { selection in
        VStack {
            TimeRangeTabBar(selection: selection)
            Text("Selected: \(selection.wrappedValue.rawValue)")
        }
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
