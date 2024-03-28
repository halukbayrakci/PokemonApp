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
    @IBOutlet weak var characterWeightLabel: UILabel!
    @IBOutlet weak var characterHeightLabel: UILabel!
    @IBOutlet weak var characterStatHP: UILabel!
    @IBOutlet weak var characterStatATK: UILabel!
    @IBOutlet weak var characterStatDEF: UILabel!
    @IBOutlet weak var characterStatSPD: UILabel!
    @IBOutlet weak var characterStatSPA: UILabel!
    @IBOutlet weak var characterStatExp: UILabel!
    @IBOutlet weak var characterHPProgressView: UIProgressView!
    @IBOutlet weak var characterATKProgressView: UIProgressView!
    @IBOutlet weak var characterDEFProgressView: UIProgressView!
    @IBOutlet weak var characterSPDProgressView: UIProgressView!
    @IBOutlet weak var characterSPAProgressView: UIProgressView!
    @IBOutlet weak var characterEXPProgressView: UIProgressView!
    
    var pokemonName: String?
    var pokemonImageURL: String?
    var pokemonId: Int?
    
    var viewModel: PokemonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterNameLabel.text = pokemonName?.uppercased()
        
        
        loadPokemonImage()
        updateUI()
        viewModel = PokemonDetailViewModel()
        
        fetchPokemonDetails(pokemonId: pokemonId!)
    }
    
    func fetchPokemonDetails(pokemonId: Int) {
        viewModel.fetchPokemonDetails(pokemonId: pokemonId) { [weak self] in
            DispatchQueue.main.async {
                self?.updateStatsUI()
            }
        }
    }
    
    
    func updateStatsUI() {
        guard let stats = viewModel.pokemon?.stats else { return }
        
        let hpStat = stats.first(where: { $0.stat.name == "hp" })?.baseStat ?? 0
        let attackStat = stats.first(where: { $0.stat.name == "attack" })?.baseStat ?? 0
        let defenseStat = stats.first(where: { $0.stat.name == "defense" })?.baseStat ?? 0
        let speedStat = stats.first(where: { $0.stat.name == "speed" })?.baseStat ?? 0
        let specialAttackStat = stats.first(where: { $0.stat.name == "special-attack" })?.baseStat ?? 0
        let specialDefenseStat = stats.first(where: { $0.stat.name == "special-defense" })?.baseStat ?? 0
        
        
        characterStatHP.text = "HP"
        characterStatATK.text = "ATK"
        characterStatDEF.text = "DEF"
        characterStatSPD.text = "SPD"
        characterStatSPA.text = "SPA"
        characterStatExp.text = "SPEED"
        
        characterWeightLabel.text = "\(viewModel.formatHeighWeight(value: self.viewModel.pokemon?.weight ?? 0))"
        characterHeightLabel.text = "\(viewModel.formatHeighWeight(value: self.viewModel.pokemon?.height ?? 0))"
        
        characterHPProgressView.progress = Float(hpStat) / 100.0
        characterATKProgressView.progress = Float(attackStat) / 100.0
        characterDEFProgressView.progress = Float(defenseStat) / 100.0
        characterSPDProgressView.progress = Float(specialDefenseStat) / 100.0
        characterSPAProgressView.progress = Float(specialAttackStat) / 100.0
        characterEXPProgressView.progress = Float(speedStat) / 100.0
        
        guard let pokemon = viewModel.pokemon else {
            print("Pokemon bilgisi yok")
            return
        }
        
        // Konsolda Pokémon detaylarını göster
        print("Pokemon Adı: \(pokemon.name)")
        print("Ağırlık: \(pokemon.weight)")
        print("Boy: \(pokemon.height)")
        
        for stat in pokemon.stats {
            print("\(stat.stat.name.uppercased()): \(stat.baseStat)")
        }
    }
    
    private func updateUI() {
        self.view.backgroundColor = UIColor(named: "redColor")
        characterDetailView.backgroundColor = .white
        //        characterDetailView.layer.cornerRadius = 400
        
    }
    
    private func loadPokemonImage() {
        if let pokemonId = extractPokemonId(from: pokemonImageURL!) {
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
