//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 27.03.2024.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
}

struct ApiConstants {
    static let getAllPokemon = "https://pokeapi.co/api/v2/pokemon?limit=50"
    static let getDetailPokemon = "https://pokeapi.co/api/v2/pokemon/"
}

protocol NetworkManagerProtocol {
    func fetchPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void)
    func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    func fetchPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        guard let url = URL(string: ApiConstants.getAllPokemon) else {
            completion(.failure(NSError(domain: "Url Error", code: 0)))
            return
        }
        let resource = Resource<PokemonList>(url: url)
        fetchData(resource: resource) { result in
            completion(result)
        }

    }
   
    func fetchPokemonDetail(pokemonID: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let url = URL(string: "\(ApiConstants.getDetailPokemon)\(pokemonID)") else {
            completion(.failure(NSError(domain: "Url Error", code: 0)))
            return
        }
        let resource = Resource<PokemonDetail>(url: url)
        fetchData(resource: resource) { result in
            completion(result)
        }
    }
 
}

extension NetworkManager {
    
    private func fetchData<T:Codable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(NSError(domain: "Response Failed", code: 0)))
                return
            }
            guard let data else {
                completion(.failure(NSError(domain: "Data is Empty", code: 0)))
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(NSError(domain: "Decode Error", code: 0)))
            }
            
        }.resume()
    }
}
