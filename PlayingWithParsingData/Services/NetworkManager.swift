//
//  NetworkManager.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 30.09.2021.
//

import Foundation

enum Link: String {
    case imageUrl = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    case exampleFive = "https://swiftbook.ru//wp-content/uploads/api/api_courses_capital"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case courseImageURL = "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, comletion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            comletion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                comletion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    comletion(.success(type))
                }
            } catch {
                comletion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func postRequest(with data: [String: Any], to url: String, completion: @escaping(Result<Any, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        guard let courseData = try? JSONSerialization.data(withJSONObject: data) else {
            completion(.failure(.noData))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = courseData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
            do {
                let course = try JSONSerialization.jsonObject(with: data)
                completion(.success(course))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

