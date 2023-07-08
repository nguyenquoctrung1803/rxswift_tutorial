//
//  UserCell.swift
//  Swift_tutorial_RxSwift
//
//  Created by Trung Nguyễn Quốc on 07/07/2023.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
