//
//  FirstCellViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 9/8/23.
//

import UIKit

class FirstCellViewController: UITableViewCell {
    
    @IBOutlet weak var countryImage: UIImageView?
    @IBOutlet weak var countryName: UILabel?
    @IBOutlet weak var circuitName: UILabel?
    @IBOutlet weak var year: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
