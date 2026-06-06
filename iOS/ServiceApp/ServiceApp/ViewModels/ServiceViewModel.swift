import Foundation
import Combine

@MainActor
class ServiceViewModel: ObservableObject {
    @Published var services: [Service] = Service.samples
    @Published var searchText: String = ""
    @Published var selectedCategory: ServiceCategory? = nil

    var filteredServices: [Service] {
        services.filter { service in
            let matchesSearch = searchText.isEmpty || service.name.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || service.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }

    func toggleAvailability(for service: Service) {
        guard let index = services.firstIndex(where: { $0.id == service.id }) else { return }
        services[index].isAvailable.toggle()
    }

    func addService(_ service: Service) {
        services.append(service)
    }

    func deleteServices(at offsets: IndexSet) {
        let filtered = filteredServices
        let ids = offsets.map { filtered[$0].id }
        services.removeAll { ids.contains($0.id) }
    }
}
