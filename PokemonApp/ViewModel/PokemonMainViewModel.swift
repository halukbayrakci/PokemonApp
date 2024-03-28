//
//  PokemonMainViewModel.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class PokemonMainViewModel {
    private let networkManager: NetworkManager
    var pokemons: [Pokemon] = []
    var pokemonDetails: [Int: PokemonDetail] = [:]
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func  fetchPokemons(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchPokemonList { [weak self] result in
            self?.pokemons = result
            completion()
        }
    }
    
    func fetchPokemonDetail(pokemonId: Int, completion: @escaping (PokemonDetail) -> Void) {
        networkManager.fetchPokemonDetail(pokemonId: pokemonId) { [weak self] result in
            if let detail = result {
                self?.pokemonDetails[pokemonId] = detail
                completion(detail)
            }
        }
    }
    
}
