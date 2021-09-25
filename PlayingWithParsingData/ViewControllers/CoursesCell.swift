//
//  CoursesCell.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 25.09.2021.
//

import UIKit

class CoursesCell: UITableViewCell {
    @IBOutlet weak var coursesImage: UIImageView!
    
    @IBOutlet weak var coursesName: UILabel!
    @IBOutlet weak var coursesLessons: UILabel!
    @IBOutlet weak var coursesTests: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
