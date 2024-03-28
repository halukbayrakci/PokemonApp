//
//  CharacterDetailViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit
import SDWebImage
import SDWebImageSVGKitPlugin

final class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var characterDetailView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    var pokemonName: String?
    var pokemonImageURL: String?
    
    var viewModel: PokemonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        characterNameLabel.text = pokemonName?.uppercased()
        
        loadPokemonImage()
        updateUI()
    }
    
    private func loadPokemonImage() {
        if let pokemonId = extractPokemonId(from: pokemonImageURL!) {
            let imageUrl = URL.createPokemonImageUrl(pokemonId: pokemonId)
            characterImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    private func extractPokemonId(from urlString: String) -> Int? {
        // URL'den Pokemon ID'sini çıkarma mantığı
        if let urlComponents = URL(string: urlString)?.pathComponents,
           let idString = urlComponents.last,
           let id = Int(idString) {
            return id
        }
        return nil
    }
    
    private func updateUI() {
        self.view.backgroundColor = UIColor(named: "redColor")
        characterDetailView.backgroundColor = .white
        characterDetailView.layer.cornerRadius = 400
        
    }
    
    
}
