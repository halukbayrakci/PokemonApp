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
    @IBOutlet weak var characterFirstType: UILabel!
    @IBOutlet weak var characterSecondType: UILabel!
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
        viewModel = PokemonDetailViewModel(pokemonID: viewModel.pokemonID)
       
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
            }
        }
    }
    
    private func showError() -> (String) -> Void {
        return { errorString in
            DispatchQueue.main.async {
                //ALERT EKLENECEK
                let alert = UIAlertController(title: "Hata", message: errorString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
  
    private func updateUI() {
      
        characterWeightLabel.text = viewModel.formattedWeight
        characterHeightLabel.text = viewModel.formattedHeight
        characterNameLabel.text = viewModel.characterName
        characterFirstType.text = viewModel.characterFirstType
        
        let secondType = viewModel.characterSecondType
        if secondType == "" {
            characterSecondType.isHidden = true
        } else {
            characterSecondType.isHidden = false
            characterSecondType.text = secondType
            characterSecondType.backgroundColor = viewModel.characterSecondTypeColor
        }
        
        characterFirstType.backgroundColor = viewModel.characterFirstTypeColor
        characterFirstType.layer.cornerRadius = 16
        characterFirstType.layer.masksToBounds = true
        characterSecondType.layer.cornerRadius = 16
        characterSecondType.layer.masksToBounds = true
        
        characterHPProgressView.progress = Float(viewModel.hpStat) / 100.0
        characterATKProgressView.progress = Float(viewModel.attackStat) / 100.0
        characterDEFProgressView.progress = Float(viewModel.defenseStat) / 100.0
        characterSPDProgressView.progress = Float(viewModel.specialDefenseStat) / 100.0
        characterSPAProgressView.progress = Float(viewModel.specialAttackStat) / 100.0
        characterEXPProgressView.progress = Float(viewModel.speedStat) / 100.0
        
    }
    
    
    private func loadPokemonImage() {
        let imageUrl = URL.createPokemonImageUrl(pokemonId: viewModel.pokemonID)
        characterImageView.sd_setImage(with: imageUrl, completed: nil)

    }
    
}
