import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel = HomeViewModel()

    @State var rowNumber = 1

    /**
     LazyVStack {
     ForEach(0...5, id: \.self) {_ in
     LazyHStack {
     ForEach(0...3, id: \.self) { _ in
     Rectangle()
     .frame(width: 50, height: 50, alignment: .center)
     .scaledToFill()
     Spacer()
     }
     }
     }
     }
     
     */
    /*
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ] */

    var columns: [GridItem] {
        var tmp = [GridItem]()

        for _ in 1...rowNumber {
            tmp.append(GridItem(.flexible()))
        }

        return tmp
    }

    /*
    var columns: [GridItem] {
        (1...rowNumber).map { GridItem(.flexible())  }
    }
     }
     */

    let data = (1...100).map { "Item \($0)" }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                    }
                }

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
