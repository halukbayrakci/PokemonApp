//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class PokemonDetailViewModel {
    private let networkManager: NetworkManager
    var pokemon: PokemonDetail?
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonDetails(pokemonId: Int, completion: @escaping () -> Void) {
        networkManager.fetchPokemonDetail(pokemonId: pokemonId) { [weak self] result in
            self?.pokemon = result
            completion()
        }
    }
    
}
