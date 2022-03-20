//
//  HeaderView.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/19.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var headerImage: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    
    func setup(image: UIImage, title: String){
        headerImage.image = image
        headerLabel.text = title
        headerImage.layer.cornerRadius = 15
        headerImage.layer.masksToBounds = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
