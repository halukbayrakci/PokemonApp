//
//  Pokemon.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct DetailedPokemon: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String? // Pokémon'un resim URL'si
    
}
