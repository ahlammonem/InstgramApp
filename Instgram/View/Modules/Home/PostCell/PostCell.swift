//
//  PostCell.swift
//  Instgram
//
//  Created by ahlam on 18/12/2023.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var viewCommentsButton: UIButton!
    @IBOutlet  var postOwnerStack: UIStackView!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postContentLabel: UILabel!
    @IBOutlet var postOwnerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

   
    
}
