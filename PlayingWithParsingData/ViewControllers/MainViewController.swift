//
//  MainViewController.swift
//  PlayingWithParsingData
//
//  Created by Dmitry Logachev on 25.09.2021.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downLoadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case ourCoursesV2 = "Capital to Lowcase"
    case postRequestWithDict = "POST RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
    case alamofireGet = "Alamofire GET"
    case alamofirePost = "Alamofire POST"
    }

class MainViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
        
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downLoadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne: exampleOneButtonPressed()
        case .exampleTwo: exampleTwoButtonPressed()
        case .exampleThree: exampleThreeButtonPressed()
        case .exampleFour: exampleFourButtonPressed()
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .ourCoursesV2: performSegue(withIdentifier: "showCoursesV2", sender: nil)
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestWithModel: postRequestWithModel()
        case .alamofireGet: performSegue(withIdentifier: "alamofireGet", sender: nil)
        case .alamofirePost: performSegue(withIdentifier: "alamofirePost", sender: nil)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            guard let coursesVC = segue.destination as? CoursesViewController else { return }
            switch segue.identifier {
            case "showCourses": coursesVC.fetchCourses()
            case "showCoursesV2": coursesVC.fetchCoursesV2()
            case "alamofireGet": coursesVC.alamofireGetButtonPressed()
            case "alamofirePost": coursesVC.alamofirePostButtonPressed()
            default: break
            }
        }
    }
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see the results in debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - Networking
extension MainViewController {
    private func exampleOneButtonPressed() {
        guard let url = URL(string: Link.exampleOne.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course)
                self.successAlert()
            } catch let error {
                self.failedAlert()
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    private func exampleTwoButtonPressed() {
        guard let url = URL(string: Link.exampleTwo.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
                self.successAlert()
            } catch let error {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }.resume()
    }
    
    private func exampleThreeButtonPressed() {
        guard let url = URL(string: Link.exampleThree.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription)
                self.successAlert()
            } catch let error {
                self.failedAlert()
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    private func exampleFourButtonPressed() {
        guard let url = URL(string: Link.exampleFour.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription)
                self.successAlert()
            } catch let error {
                self.failedAlert()
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    private func postRequestWithDict() {
        
    }
    
    private func postRequestWithModel() {
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
