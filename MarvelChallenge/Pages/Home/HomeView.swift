import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                Text("Aqui entram as lazy stacks")
            }
        }
        .onAppear {
            viewModel.loadMore()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext,
             PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 13")
    }
}
