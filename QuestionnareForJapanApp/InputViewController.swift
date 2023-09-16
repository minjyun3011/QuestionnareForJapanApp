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
        TravelNumberLabel.text = String(travelNum)
        ContentName.text = String(questionNum)
    }
    //    TravelNumberLabel.text = String?(travelNum)
    //    ContentName.text = String?(questionNum)
    
    @IBAction func imageTap(_ sender: Any) {
        print("GoToSetImage")
        let nextVC = self.storyboard?.instantiateViewController(identifier: "imageSetViewController")as! ImageSetViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //    アラートでカメラorアルバムの選択をさせる
    func showAlert(){
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.checkCamera()
        }
        
        let albumAction = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.checkAlbum()
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }
    //    カメラ立ち上げメソッド
    func checkCamera(){
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //        カメラ利用可能かチェック
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            present(cameraPicker, animated: true,completion: nil)
            
        }
    }
    //    フォトライブラリの使用
    func checkAlbum() {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //        フォトライブラリのチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            present(cameraPicker, animated: true,completion: nil)
        }
    }
    //    カメラとアルバムを受け取るメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage]! as? UIImage {
            UserDefaults.standard.set(editedImage.jpegData(compressionQuality: 0.1), forKey: "userImage")
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    //  imageTap.image = editedImage
    
    /* 追加 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func addContents(_ sender: Any) {
        showAlert2()
        let userDefaults = UserDefaults.standard
        userDefaults.set(travelNum, forKey: "questions")
        userDefaults.set(questionNum, forKey: "questions")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAdd(_ sender: Any) {
        showAlert2()
    }
    
    func showAlert2(){
        let alertController = UIAlertController(title: "Add", message: "Do you really want to add it?", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] (alert) in
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.travelNum, forKey: "questions")
            userDefaults.set(self.questionNum, forKey: "questions")
            self.navigationController?.popViewController(animated: true)
        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController,animated: true,completion: nil)
    }


