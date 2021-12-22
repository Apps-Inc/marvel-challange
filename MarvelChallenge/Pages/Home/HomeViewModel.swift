//
//  HomeViewModel.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 22/12/21.
//

import Foundation

protocol ViewModel {
    func loadMore()

    var marvelService: Service { get }
    var isLoading: Bool { get set}
    // ver se chegou no pagina final pra parar de fazer request
    var hasEnded: Bool { get set }

    // alertar qual foi o erro
    var error: String { get set }

    // pagina atual
    var currentPage: Int { get set }

}

class HomeViewModel: ViewModel, ObservableObject {
    @Published var eventsList = [EventModel]()
    @Published var isLoading: Bool = false

    internal var marvelService: Service = MarvelService()
    var currentPage: Int = 0

    var hasEnded: Bool = false

    var error: String = ""

    private func getEvents(_ page: Int = 1) {
        marvelService.fetchEvents(page: page) { [weak self] result in
            switch result {
            case .success(let data):
                self?.isLoading = false
                self?.eventsList.append(contentsOf: data.data?.results ?? [])
                if data.data?.total == self?.eventsList.count {
                    self?.hasEnded = true
                }
            case .error(let erro):
                self?.error = erro.localizedDescription
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            default:
                self?.error = "No content"
                debugPrint("Um erro aconteceu: \(String(describing: self?.error))")
            }
        }
    }

    func loadMore() {
        guard !isLoading  else {
            debugPrint("Fazendo chamada durante carregamento/ request acabou")
            return
        }

        guard !hasEnded else {
            debugPrint("Fazendo request e dados acabaram")
            return
        }

        isLoading = true

        currentPage += 1

        getEvents(currentPage)

    }
}
