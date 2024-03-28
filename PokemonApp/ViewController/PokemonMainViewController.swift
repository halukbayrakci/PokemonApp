//
//  ViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit

final class PokemonMainViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    
    private var viewModel = PokemonMainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reload = reloadTableView()
        viewModel.error = showError()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let selectedIndex = sender as? Int {
                    let vm = PokemonDetailViewModel(pokemonID: viewModel.extractPokemonId(from: selectedIndex))
                    detailVC.viewModel = vm
                }
            }
        }
    }
    
    private func reloadTableView() -> () -> Void {
        return {
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }
    
    private func showError() -> (String) -> Void {
        return { errorString in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Hata", message: errorString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
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
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

