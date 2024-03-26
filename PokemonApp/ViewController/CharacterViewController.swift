//
//  ViewController.swift
//  PokemonApp
//
//  Created by HALUK BAYRAKCI on 26.03.2024.
//

import UIKit

final class CharacterViewController: UIViewController {
    @IBOutlet weak var characterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = characterTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("not cell identifier")
        }
        
        cell.characterImageView.image = UIImage(named: "pokeBall")
        cell.characterNameLabel.text = "BULBASAUR"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

