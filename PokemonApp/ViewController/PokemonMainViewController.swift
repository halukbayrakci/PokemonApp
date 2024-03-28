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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? PokemonDetailViewController, let pokemon = sender as? Pokemon {
                detailVC.pokemonName = pokemon.name
                detailVC.pokemonImageURL = "\(pokemon.url)"
                
                print("Segue ile aktarılan Pokémon:", pokemon.name)
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
        
        let pokemon = viewModel.pokemons[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: pokemon)
    }
}

