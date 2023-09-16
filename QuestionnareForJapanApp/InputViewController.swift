//
//  InputViewController.swift
//  QuestionnareForJapanApp
//
//  Created by 佐藤壮 on 2023/09/14.
//

import UIKit

class InputViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var travelNum: String?
    var questionNum: String?
    
    @IBOutlet weak var TravelNumberLabel: UILabel!
    
    @IBOutlet weak var ContentName: UILabel!
    
    @IBOutlet weak var imageComment: UILabel!
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(travelNum)
        print(questionNum)
        let userDefaults = UserDefaults.standard
        userDefaults.object(forKey: "questions")
        TravelNumberLabel.text = travelNum!
        ContentName.text = questionNum!
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
            userDefaults.set(self.travelNum, forKey: "questions")
            userDefaults.set(self.questionNum, forKey: "questions")
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
}


