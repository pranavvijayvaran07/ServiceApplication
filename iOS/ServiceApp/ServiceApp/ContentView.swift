import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ServiceViewModel()

    var body: some View {
        NavigationStack {
            ServiceListView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}
