import SwiftUI

struct AddServiceView: View {
    @EnvironmentObject var viewModel: ServiceViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var description = ""
    @State private var category: ServiceCategory = .cleaning
    @State private var price: Double = 0
    @State private var isAvailable = true

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && price > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Service name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Category & Pricing") {
                    Picker("Category", selection: $category) {
                        ForEach(ServiceCategory.allCases, id: \.self) { cat in
                            Label(cat.rawValue, systemImage: cat.systemImage).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)

                    HStack {
                        Text("Price")
                        Spacer()
                        TextField("0.00", value: $price, format: .currency(code: "USD"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section {
                    Toggle("Available", isOn: $isAvailable)
                }
            }
            .navigationTitle("Add Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let service = Service(
                            name: name,
                            description: description,
                            category: category,
                            isAvailable: isAvailable,
                            price: price
                        )
                        viewModel.addService(service)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    AddServiceView()
        .environmentObject(ServiceViewModel())
}
