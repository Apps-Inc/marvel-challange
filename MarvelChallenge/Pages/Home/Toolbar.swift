//
//  Toolbar.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 23/12/21.
//

import SwiftUI

struct ToolbarItens: ToolbarContent {

    var referencedViewModel: ToolbarViewModel

    init(viewModel: ToolbarViewModel) {
        self.referencedViewModel = viewModel
    }

    var rowCount = 1

    var body: some ToolbarContent {

        ToolbarItemGroup(placement: .navigationBarLeading) {
            Text("Eventos")
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            if referencedViewModel.rowCount == 1 {
                Button {
                    referencedViewModel.changeRowCount()
                } label: {
                    Image(systemName: "square.grid.2x2")
                }
            } else {
                Button {
                    referencedViewModel.changeRowCount()
                } label: {
                    Image(systemName: "list.triangle")
                }
            }
        }
    }

    }

class ToolbarViewModel: ObservableObject {
    @Published var rowCount: Int = 1

    func changeRowCount() {
        if rowCount == 1 {
            rowCount = 2
            return
        }
        rowCount = 1
    }

}
