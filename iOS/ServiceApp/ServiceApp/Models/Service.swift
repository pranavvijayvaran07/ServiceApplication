import Foundation

struct Service: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var category: ServiceCategory
    var isAvailable: Bool
    var price: Double

    init(id: UUID = UUID(), name: String, description: String, category: ServiceCategory, isAvailable: Bool = true, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.isAvailable = isAvailable
        self.price = price
    }
}

enum ServiceCategory: String, CaseIterable, Codable {
    case cleaning = "Cleaning"
    case repair = "Repair"
    case delivery = "Delivery"
    case consulting = "Consulting"

    var systemImage: String {
        switch self {
        case .cleaning:  return "sparkles"
        case .repair:    return "wrench.and.screwdriver"
        case .delivery:  return "shippingbox"
        case .consulting: return "person.fill.questionmark"
        }
    }
}

extension Service {
    static let samples: [Service] = [
        Service(name: "Home Cleaning", description: "Professional deep cleaning for your entire home.", category: .cleaning, price: 120.0),
        Service(name: "Plumbing Repair", description: "Fix leaks, clogs, and pipe issues quickly.", category: .repair, price: 85.0),
        Service(name: "Same-Day Delivery", description: "Fast delivery within city limits.", category: .delivery, price: 15.0),
        Service(name: "IT Consulting", description: "Expert advice for your tech needs.", category: .consulting, price: 200.0),
        Service(name: "Carpet Cleaning", description: "Steam clean carpets and rugs.", category: .cleaning, price: 75.0),
        Service(name: "Appliance Repair", description: "Repair for washers, dryers, and more.", category: .repair, isAvailable: false, price: 95.0),
    ]
}
