//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    
    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(100)"
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                let pokemons = pokemonResponse.results.map { Pokemon(name: $0.name, url: $0.url) }
                completion(pokemons)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
    
    func fetchPokemonImageURL(pokemonDetailURL: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: pokemonDetailURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let details = try JSONDecoder().decode(DetailedPokemon.self, from: data)
                completion(details.sprites.front_default)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
