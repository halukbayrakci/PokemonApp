//
//  Pokemon.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

struct PokemonList: Codable {
    let  results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}



