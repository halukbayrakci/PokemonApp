//
//  ViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit
import SDWebImage

final class CharacterViewController: UIViewController {
    @IBOutlet weak var characterTableView: UITableView!
    
    var pokemons: [Pokemon] = []
    var pokemonImages: [String: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        NetworkManager.shared.fetchPokemons { [weak self ] result in
            self?.pokemons = result
            DispatchQueue.main.async {
                self?.characterTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? CharacterDetailViewController, let pokemon = sender as? Pokemon {
                detailVC.pokemonName = pokemon.name
                detailVC.pokemonImageURL = "\(pokemon.url)"
                
                print("Segue ile aktarılan Pokémon:", pokemon.name)
            }
        }
    }
    
}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon = pokemons[indexPath.row]
        
        guard let cell = characterTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("not cell identifier")
        }
        
        NetworkManager.shared.fetchPokemonImageURL(pokemonDetailURL: pokemon.url) { imageURL in
            guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
            DispatchQueue.main.async {
                cell.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "\(pokemon.name)"))
            }
        }
        
        cell.characterImageView.image = pokemonImages[pokemon.name]
        cell.characterNameLabel.text = pokemon.name.uppercased()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = pokemons [indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: pokemon)
    }
}

