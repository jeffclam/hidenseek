//
//  PlayerViewCell.swift
//  hideNSeek
//
//  Created by Local Account 436-18 on 11/14/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import Foundation
import UIKit

class PlayerViewCell : UITableViewCell {
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
