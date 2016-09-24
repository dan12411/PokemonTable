//
//  ViewController.swift
//  PokemonTable
//
//  Created by 洪德晟 on 2016/9/23.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemoninImage: UIImage?
    var pokemonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let pokemoninImage = self.pokemoninImage {
            self.pokemonImage.image = pokemoninImage
        }
        
        if let pokemonName = self.pokemonName {
            self.nameLabel.text = pokemonName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

