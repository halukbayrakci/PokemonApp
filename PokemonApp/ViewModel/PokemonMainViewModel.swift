//
//  PokemonMainViewModel.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class PokemonMainViewModel {
    private let networkManager: NetworkManagerProtocol
    var pokemons: [Pokemon] = []
    var reload: (()-> Void)?
    var error: ((String)-> Void)?
    
    init() {
        self.networkManager = NetworkManager()
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        networkManager.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.pokemons = pokemonList.results ?? []
                self?.reload?()
            case .failure(let error):
                self?.error?(error.localizedDescription)
            }
        }
    }
    
    func extractPokemonId(from index: Int) -> Int {
        if let urlComponents = URL(string: pokemons[index].url ?? "" )?.pathComponents,
           let idString = urlComponents.last,
           let id = Int(idString) {
            return id
        }
        return 0
    }
    
    
}
