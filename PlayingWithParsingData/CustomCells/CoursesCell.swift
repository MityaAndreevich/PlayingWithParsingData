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
        coursesLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        coursesTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: course.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.coursesImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(with courseV2: CourseV2) {
        coursesName.text = courseV2.name
        coursesLessons.text = "Number of lessons: \(courseV2.numberOfLessons ?? 0)"
        coursesTests.text = "Number of tests: \(courseV2.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: courseV2.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.coursesImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
