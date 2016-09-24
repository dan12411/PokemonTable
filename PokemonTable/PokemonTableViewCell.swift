//
//  PokemonTableViewCell.swift
//  PokemonTable
//
//  Created by 洪德晟 on 2016/9/23.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonMaxCP: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
