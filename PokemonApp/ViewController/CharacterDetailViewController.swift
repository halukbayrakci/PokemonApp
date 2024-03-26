//
//  CharacterDetailViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var characterDetailView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    private func updateUI() {
        self.view.backgroundColor = UIColor(named: "redColor")
        characterDetailView.backgroundColor = .white
        characterDetailView.layer.cornerRadius = 400
        
    }
    
}
