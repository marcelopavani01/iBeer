//
//  BeerTableViewCell.swift
//  iBeer
//
//  Created by Marcelo Pavani on 24/05/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imgBeer: UIImageView!
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelAbv: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
