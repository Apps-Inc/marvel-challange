//
//  HomeViewModel.swift
//  MarvelChallenge
//
//  Created by DIOGO OLIVEIRA NEISS on 22/12/21.
//

import Foundation

protocol ViewModel {
    func loadMore()

    var marvelService: MarvelService { get }
    var isLoading: Bool { get set}
    //ver se chegou no pagina final pra parar de fazer request
    var hasEnded: Bool { get set }
    
    //alertar qual foi o erro
    var error: String { get set }
    
    //pagina atual
    var currentPage: Int { get set }

}

class HomeViewModel: ViewModel, ObservableObject {

    @Published var mainRequest: EventsMainRequest?
    @Published var eventsList = [Event]()

    internal var marvelService: MarvelService = MarvelServiceImp()
    var currentPage: Int = 0
    var isLoading: Bool = false

    var hasEnded: Bool = false

    var error: String = ""

    func loadMore() {

    }
}
