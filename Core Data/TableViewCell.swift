//
//  TableViewCell.swift
//  Core Data
//
//  Created by Karthiga on 9/27/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print (label2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
