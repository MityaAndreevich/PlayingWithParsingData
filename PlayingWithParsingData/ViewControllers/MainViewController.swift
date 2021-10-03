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
        
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        
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
        if segue.identifier != "showImage" {
            let coursesVC = segue.destination as! CoursesViewController
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
        NetworkManager.shared.fetch(dataType: Course.self, from: Link.exampleOne.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleTwoButtonPressed() {
        NetworkManager.shared.fetch(dataType: [Course].self, from: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.successAlert()
                for course in courses {
                    print("Courses: \(course.name ?? "")")
                }
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleThreeButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, from: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleFourButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, from: Link.exampleFour.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func postRequestWithDict() {
        let course = [
            "name": "Networking",
            "imageUrl": "image url",
            "numberOfLessons": "10",
            "numberOfTests": "8"
        ]
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func postRequestWithModel() {
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
