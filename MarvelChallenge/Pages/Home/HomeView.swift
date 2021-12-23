import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel = HomeViewModel()

    @StateObject var toolbarViewModel = ToolbarViewModel()

    var rowNumber: Int {
       return toolbarViewModel.rowCount
    }

    var columns: [GridItem] {
        var tmp = [GridItem]()

        for _ in 1...rowNumber {
            tmp.append(GridItem(.flexible()))
        }

        return tmp
    }

    var body: some View {

        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(viewModel.eventsList.indexed(), id: \.element.id) { (index, event) in
                        Group {
                            if rowNumber == 1 {
                                CellInLineView(event: event)
                            } else {
                                CellCardView(event: event)
                            }
                        }
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentIndex: index)
                        }
                    }
                }
                if viewModel.isLoading {
                    ProgressView().scaleEffect(2)

                        .padding()
                }

            }
            .toolbar(content: {
                ToolbarItens(viewModel: toolbarViewModel)
            })
            .navigationBarTitleDisplayMode(.inline)
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
