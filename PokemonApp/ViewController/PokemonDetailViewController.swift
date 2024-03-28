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
    
    var viewModel: PokemonDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        viewModel.reload = updateUIfun()
        viewModel.error = showError()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        characterImageView.image = nil
    }
    private func updateUIfun() -> () -> Void {
        return {
            DispatchQueue.main.async {
                self.loadPokemonImage()
                self.updateUI()
                self.updateStatsUI()
            }
        }
    }
    
    private func showError() -> (String) -> Void {
        return { errorString in
            DispatchQueue.main.async {
                //ALERT EKLENECEK
            }
        }
    }
  
    
    func updateStatsUI() {
        guard let stats = viewModel.pokemon?.stats else { return }
        
        let hpStat = stats.first(where: { $0.stat?.name == "hp" })?.baseStat ?? 0
        let attackStat = stats.first(where: { $0.stat?.name == "attack" })?.baseStat ?? 0
        let defenseStat = stats.first(where: { $0.stat?.name == "defense" })?.baseStat ?? 0
        let speedStat = stats.first(where: { $0.stat?.name == "speed" })?.baseStat ?? 0
        let specialAttackStat = stats.first(where: { $0.stat?.name == "special-attack" })?.baseStat ?? 0
        let specialDefenseStat = stats.first(where: { $0.stat?.name == "special-defense" })?.baseStat ?? 0
        
        //storyboarddan verilecek
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
        
//        guard let pokemon = viewModel.pokemon else {
//            print("Pokemon bilgisi yok")
//            return
//        }
//        
//        // Konsolda Pokémon detaylarını göster
//        print("Pokemon Adı: \(pokemon.name)")
//        print("Ağırlık: \(pokemon.weight)")
//        print("Boy: \(pokemon.height)")
//        
//        for stat in pokemon.stats ?? [] {
//            print("\(stat.stat?.name?.uppercased()): \(stat.baseStat)")
//        }
    }
    
    private func updateUI() {
        //storyboarddan verilecek
        self.view.backgroundColor = UIColor(named: "redColor")
        characterDetailView.backgroundColor = .white
        //characterDetailView.layer.cornerRadius = 400
        characterNameLabel.text = viewModel.characterName
        
    }
    
    private func loadPokemonImage() {
        let imageUrl = URL.createPokemonImageUrl(pokemonId: viewModel.pokemonID)
        characterImageView.sd_setImage(with: imageUrl, completed: nil)

    }
    
}
