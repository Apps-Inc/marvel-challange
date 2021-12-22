import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        Text("Hello, marvel")
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
