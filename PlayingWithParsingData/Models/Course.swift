//
//  Course.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 25.09.2021.
//

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct CourseV2: Decodable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case imageUrl = "ImageUrl"
        case numberOfLessons = "Number_of_lessons"
        case numberOfTests = "Number_of_tests"
    }
}

struct WebsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
