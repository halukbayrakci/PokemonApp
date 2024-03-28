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
    let stats: [PokemonStat]
    let types: [TypeElement]
    let sprites: Sprites?
}
struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct TypeElement: Codable {
    let slot    : Int
    let type    : Species
}
struct Species: Codable {
    let name    : String
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

