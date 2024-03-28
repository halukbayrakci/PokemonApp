//
//  Ability.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
//    let species: NamedAPIResource // About için
//    let abilities: [PokemonAbility]
    let sprites: Sprites?
}
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

struct PokemonAbility: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedAPIResource
}

struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

