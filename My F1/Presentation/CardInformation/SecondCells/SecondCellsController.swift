//
//  SecondCellsController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 9/8/23.
//

import UIKit

class SecondCellsController: UITableViewCell {

    @IBOutlet weak var position: UILabel?
    @IBOutlet weak var famName: UILabel?
    @IBOutlet weak var team: UILabel?
    @IBOutlet weak var points: UILabel?
    var urlDriver: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
