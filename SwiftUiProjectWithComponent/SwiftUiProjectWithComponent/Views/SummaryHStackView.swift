import SwiftUI

struct SummaryHStackView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text("Primary")
                    .font(.subheadline).bold()
                Text("Subtitle")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 1, height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text("Status")
                    .font(.subheadline).bold()
                Text("Updated today")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    SummaryHStackView()
}
