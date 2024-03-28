//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import UIKit

class PokemonDetailViewModel {
    private let networkManager: NetworkManagerProtocol
    var pokemon: PokemonDetail?
    var pokemonID: Int
    var reload: (()-> Void)?
    var error: ((String)-> Void)?
    
    var characterName: String {
        return pokemon?.name?.uppercased() ?? ""
    }
    var formattedWeight: String {
        let weight = pokemon?.weight ?? 0
        return formatHeighWeight(value: weight)
    }
    var formattedHeight: String {
        let height = pokemon?.height ?? 0
        return formatHeighWeight(value: height)
    }
    var hpStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "hp" })?.baseStat ?? 0
    }
    var attackStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "attack" })?.baseStat ?? 0
    }
    var defenseStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "defense" })?.baseStat ?? 0
    }
    var speedStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "speed" })?.baseStat ?? 0
    }
    var specialAttackStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "special-attack" })?.baseStat ?? 0
    }
    var specialDefenseStat: Int {
        return pokemon?.stats?.first(where: { $0.stat?.name == "special-defense" })?.baseStat ?? 0
    }
    var characterFirstType: String {
        return pokemon?.types?.first?.type?.name?.uppercased() ?? ""
    }
    var characterSecondType: String {
        if let types = pokemon?.types, types.count > 1 {
                return types[1].type?.name?.uppercased() ?? "Unknown"
            } else {
                return ""
            }
    }
    var characterFirstTypeColor: UIColor {
            let typeColor = TypeColors()
            let firstType = characterFirstType.lowercased()
            return typeColor.fetchColor(colorName: firstType)
    }
    var characterSecondTypeColor: UIColor {
            let typeColor = TypeColors()
            let secondType = characterSecondType.lowercased()
            return typeColor.fetchColor(colorName: secondType)
    }
    
    
    init(pokemonID: Int) {
        self.networkManager = NetworkManager()
        self.pokemonID = pokemonID
        fetchDetailPokemon(pokemonID: pokemonID)
    }
    
    private func fetchDetailPokemon(pokemonID: Int) {
//        print("Pokemon ayrıntıları yükleniyor, ID: \(pokemonID)")
        networkManager.fetchPokemonDetail(pokemonID: pokemonID) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                self?.pokemon = pokemonDetail
                self?.printPokemonTypes(pokemonDetail)
                print("İlk Tip: \(self?.characterFirstType ?? "Bilinmiyor")")
                print("İkinci Tip: \(self?.characterSecondType ?? "Bilinmiyor")")
                self?.reload?()
            case .failure(let error):
                self?.error?(error.localizedDescription)
                print("Hata: \(error.localizedDescription)")
            }
        }
    }
    
    private func printPokemonTypes(_ pokemonDetail: PokemonDetail) {
            if let types = pokemonDetail.types {
                for type in types {
                    print("Type name: \(type.type?.name ?? "Unknown")")
                }
            } else {
                print("No types available for this Pokémon.")
            }
        }
    
    func formatHeighWeight(value : Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.1f", dValue / 10)
        return string
    }
}
