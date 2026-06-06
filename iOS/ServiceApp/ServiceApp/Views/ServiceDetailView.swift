import SwiftUI

struct ServiceDetailView: View {
    @EnvironmentObject var viewModel: ServiceViewModel
    let service: Service

    private var currentService: Service {
        viewModel.services.first(where: { $0.id == service.id }) ?? service
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                header
                    .padding()

                Divider()

                details
                    .padding()
            }
        }
        .navigationTitle(service.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(currentService.isAvailable ? "Mark Unavailable" : "Mark Available") {
                    viewModel.toggleAvailability(for: currentService)
                }
                .tint(currentService.isAvailable ? .red : .green)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 16) {
            Image(systemName: currentService.category.systemImage)
                .font(.system(size: 56))
                .foregroundStyle(.white)
                .frame(width: 100, height: 100)
                .background(currentService.isAvailable ? Color.accentColor : Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .shadow(radius: 4)

            Text(currentService.name)
                .font(.title2)
                .fontWeight(.bold)

            Text(currentService.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var details: some View {
        VStack(spacing: 12) {
            detailRow(label: "Category", value: currentService.category.rawValue, icon: currentService.category.systemImage)
            detailRow(label: "Price", value: currentService.price.formatted(.currency(code: "USD")), icon: "dollarsign.circle")
            detailRow(label: "Status", value: currentService.isAvailable ? "Available" : "Unavailable", icon: "info.circle")
        }
    }

    private func detailRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Label(label, systemImage: icon)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        ServiceDetailView(service: Service.samples[0])
            .environmentObject(ServiceViewModel())
    }
}
