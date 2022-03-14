//
//  DayTableViewCell.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/14.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentBackground: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
