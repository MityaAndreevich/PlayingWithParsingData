//
//  Course.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 25.09.2021.
//

struct Course: Decodable {
    let name: String
    let imageURL: String
    let number_of_lessons: Int
    let number_of_tests: Int
}
