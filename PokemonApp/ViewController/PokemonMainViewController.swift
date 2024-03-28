//
//  ViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit
final class PokemonMainViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var viewModel = PokemonMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        viewModel.fetchPokemons { [weak self] in
            DispatchQueue.main.async {
                self?.pokemonTableView.reloadData()
            }
        }
    }
    
    private func extractPokemonId(from urlString: String) -> Int? {
        if let urlComponents = URL(string: urlString)?.pathComponents,
           let idString = urlComponents.last,
           let id = Int(idString) {
            return id
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let selectedIndex = sender as? Int {
                    let selectedPokemon = viewModel.pokemons[selectedIndex]
                    detailVC.pokemonId = extractPokemonId(from: selectedPokemon.url)
                    detailVC.pokemonName = selectedPokemon.name
                    detailVC.pokemonImageURL = "\(selectedPokemon.url)"
                    print("Segue ile aktarılan Pokémon:", selectedPokemon.name)
                }
            }
        }
    }
    
    
}

extension PokemonMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon = viewModel.pokemons[indexPath.row]
        
        guard let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonTableViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        cell.configure(with: pokemon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        let pokemon = viewModel.pokemons[indexPath.row]
        let selectedPokemon = viewModel.pokemons[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

