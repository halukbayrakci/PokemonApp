//
//  CharacterTableViewCell.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit
import SDWebImage
import SDWebImageSVGKitPlugin

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 15
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configure(with pokemon: Pokemon) {
        characterNameLabel.text = pokemon.name.uppercased()
        
        if let pokemonId = extractPokemonId(from: pokemon.url) {
            let imageUrl = URL.createPokemonImageUrl(pokemonId: pokemonId)
            characterImageView.sd_setImage(with: imageUrl, completed: nil)
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
    
    
    
    
}
