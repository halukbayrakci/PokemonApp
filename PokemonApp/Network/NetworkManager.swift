//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchPokemonList(completion: @escaping ([Pokemon]) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=50"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let pokemonListResponse = try JSONDecoder().decode(PokemonList.self, from: data)
                completion(pokemonListResponse.results)
            } catch {
                completion([])
            }
        }.resume()
    }
    
    func fetchPokemonDetail(pokemonId: Int, completion: @escaping (PokemonDetail?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemonId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(pokemonDetail)
            } catch {
                print("Error decoding Pokemon detail:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
