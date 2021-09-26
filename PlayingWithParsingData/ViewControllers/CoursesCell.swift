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
    
    func configure(with course: Course) {
        coursesName.text = course.name
        coursesLessons.text = "Number of lessons: \(course.number_of_lessons ?? 0)"
        coursesTests.text = "Number of tests: \(course.number_of_tests ?? 0)"
        guard let url = URL(string: course.imageUrl ?? "") else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.coursesImage.image = UIImage(data: imageData)
        }
    }
}
