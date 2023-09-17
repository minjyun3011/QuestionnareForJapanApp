//
//  InputViewController.swift
//  QuestionnareForJapanApp
//
//  Created by 佐藤壮 on 2023/09/14.
//

import UIKit
import Firebase

class InputViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var travelNum: String?
    var questionNum: String?
    var userInput: String = ""
    var imageCommentText: String = ""
    
    @IBOutlet weak var TravelNumberLabel: UILabel!
    
    @IBOutlet weak var ContentName: UILabel!
    
    @IBOutlet weak var imageComment: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let userName =  UserDefaults.standard.object(forKey: "userName") as? String {
            imageComment.text = userName
        }
        if let data = UserDefaults.standard.object(forKey: "userImage") as? Data {
            imageView.image = UIImage(data: data)
        }
            
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(travelNum)
        print(questionNum)
        
        if let userName =  UserDefaults.standard.object(forKey: "userName") as? String {
            imageComment.text = userName
        }
        
        TravelNumberLabel.text = travelNum!
        ContentName.text = questionNum!

        if let questions =  UserDefaults.standard.object(forKey: "questions") as? [String: [String: Any]] {
//            if let oldinput = questions[travelNum][questionNum] {
//                userInput = oldinput
//            }
            if let oldInput = questions[travelNum!]?[questionNum!] as? [String: Any] {
                textField.text = oldInput["text"] as! String
            }
        }
        
        
//        textField.text = userInput
        
        
        }
    
    //    TravelNumberLabel.text = String?(travelNum)
    //    ContentName.text = String?(questionNum)
    
    @IBAction func imageTap(_ sender: Any) {
        print("GoToSetImage")
        let nextVC = self.storyboard?.instantiateViewController(identifier: "imageSetViewController")as! ImageSetViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func addContents(_ sender: Any) {
        showAlert2()
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert2(){
        let alertController = UIAlertController(title: "Add", message: "Do you really want to add it?", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] (alert) in
            let userDefaults = UserDefaults.standard
//            userDefaults.set(self.travelNum, forKey: "questions")
//            userDefaults.set(self.questionNum, forKey: "q")
//            userDefaults.set(self.textField.text!, forKey: "qu")
            
            let questions: [String : Any] = [
                self.travelNum!: [
                    self.questionNum: [
                        "text": self.textField.text!,
//                        "image": ****,
//                            "comment": ***
                    ]
                ]
            ]
            userDefaults.set(questions, forKey: "questions")
            
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
}


