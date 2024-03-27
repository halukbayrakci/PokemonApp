//
//  CharacterDetailViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit
import SDWebImage

final class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var characterDetailView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
        
    var pokemonName: String?
    var pokemonImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        characterNameLabel.text = pokemonName?.uppercased()
        fetchPokemonImage()
        updateUI()

    }
    
    private func updateUI() {
        self.view.backgroundColor = UIColor(named: "redColor")
        characterDetailView.backgroundColor = .white
        characterDetailView.layer.cornerRadius = 400
        
    }
    
    private func fetchPokemonImage() {
        NetworkManager.shared.fetchPokemonImageURL(pokemonDetailURL: pokemonImageURL!) { imageURL in
            guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
            DispatchQueue.main.async {
                self.characterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "\(self.pokemonName!)"))
            }
        }
    }
    
   


    
    
}
