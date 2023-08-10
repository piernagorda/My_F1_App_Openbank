//
//  HomeCellCollectionViewCell.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 8/8/23.
//

import UIKit

class HomeCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Country: UILabel?
    @IBOutlet weak var CircuitName: UILabel?
    @IBOutlet weak var CountryFlag: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CountryFlag?.layer.cornerRadius = 10
        CountryFlag?.clipsToBounds = true
        CountryFlag?.layer.borderWidth = 1
        CountryFlag?.layer.borderColor = UIColor.black.cgColor
    }

}
