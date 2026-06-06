import SwiftUI

struct ServiceRowView: View {
    let service: Service

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: service.category.systemImage)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(service.isAvailable ? Color.accentColor : Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(service.name)
                    .font(.headline)
                Text(service.category.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(service.price, format: .currency(code: "USD"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(service.isAvailable ? "Available" : "Unavailable")
                    .font(.caption2)
                    .foregroundStyle(service.isAvailable ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        ServiceRowView(service: Service.samples[0])
        ServiceRowView(service: Service.samples[5])
    }
}
