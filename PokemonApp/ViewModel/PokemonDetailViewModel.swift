//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class PokemonDetailViewModel {
    private let networkManager: NetworkManagerProtocol
    var pokemon: PokemonDetail?
    var pokemonID: Int
    var reload: (()-> Void)?
    var error: ((String)-> Void)?
    var characterName: String {
        return pokemon?.name?.uppercased() ?? ""
    }
    
    init(pokemonID: Int) {
        self.networkManager = NetworkManager()
        self.pokemonID = pokemonID
        fetchDetailPokemon(pokemonID: pokemonID)
    }
    
    private func fetchDetailPokemon(pokemonID: Int) {
        networkManager.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.pokemon = pokemonDetail
                self?.reload?()
            case .failure(let error):
                self?.error?(error.localizedDescription)
            }
        }
    }
    
    func formatHeighWeight(value : Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.1f", dValue / 10)
        return string
    }
}
