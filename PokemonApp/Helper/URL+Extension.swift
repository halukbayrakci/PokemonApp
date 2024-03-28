//
//  PokemonImageHelper.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 28.03.2024.
//

import Foundation

extension URL {
    static func createPokemonImageUrl(pokemonId: Int) -> URL? {
        let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/"
        return URL(string: "\(baseUrl)\(pokemonId).svg")
    }
}

