//
//  StateCell.swift
//  License Plates
//
//  Created by Brandon on 5/4/17.
//  Copyright © 2017 Utah State University. All rights reserved.
//

import UIKit

class StateCell: UITableViewCell {
    
    
    @IBOutlet weak var State: UILabel!
    @IBOutlet weak var Score: UILabel!
    var timesfound = 0
    
    func found()
    {
     timesfound += 1
    }
    
    func resetcell()
    {
    timesfound = 0
    self.backgroundColor = UIColor.clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
