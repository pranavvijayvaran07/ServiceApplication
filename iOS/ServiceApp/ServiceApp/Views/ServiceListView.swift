import SwiftUI

struct ServiceListView: View {
    @EnvironmentObject var viewModel: ServiceViewModel
    @State private var showingAddService = false

    var body: some View {
        Group {
            if viewModel.filteredServices.isEmpty {
                emptyState
            } else {
                list
            }
        }
        .navigationTitle("Services")
        .searchable(text: $viewModel.searchText, prompt: "Search services")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                categoryFilter
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddService = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddService) {
            AddServiceView()
                .environmentObject(viewModel)
        }
    }

    private var list: some View {
        List {
            ForEach(viewModel.filteredServices) { service in
                NavigationLink(destination: ServiceDetailView(service: service)) {
                    ServiceRowView(service: service)
                }
            }
            .onDelete(perform: viewModel.deleteServices)
        }
        .listStyle(.insetGrouped)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("No services found")
                .font(.headline)
            Text("Try adjusting your search or filters.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    private var categoryFilter: some View {
        Menu {
            Button("All Categories") {
                viewModel.selectedCategory = nil
            }
            Divider()
            ForEach(ServiceCategory.allCases, id: \.self) { category in
                Button {
                    viewModel.selectedCategory = category
                } label: {
                    Label(category.rawValue, systemImage: category.systemImage)
                }
            }
        } label: {
            Label(viewModel.selectedCategory?.rawValue ?? "Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}

#Preview {
    NavigationStack {
        ServiceListView()
            .environmentObject(ServiceViewModel())
    }
}
