//
//  ImageSetViewController.swift
//  QuestionnareForJapanApp
//
//  Created by 佐藤壮 on 2023/09/15.
//

import UIKit
import Firebase

class ImageSetViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageComment: String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageComments: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func imageButton(_ sender: Any) {
        showAlert()
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
            imageView.image = editedImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToListButton(_ sender: Any) {
        //        ユーザー名
        let userDefaults = UserDefaults.standard
        UserDefaults.standard.set(imageComments.text, forKey: "userName")
        let data = imageView.image?.jpegData(compressionQuality: 0.1)
        UserDefaults.standard.set(data, forKey: "userImage")
        //        画面遷移
//        let nextVC = self.storyboard?.instantiateViewController(identifier: "itemTableViewController")as! ItemTableViewController
//        self.navigationController?.pushViewController(nextVC, animated: true)
        if let targetViewController = navigationController?.viewControllers.dropLast(2).last {
            navigationController?.popToViewController(targetViewController, animated: true)
        }

    }
        /* 追加 */
        //    キーボードを下げる
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            imageComments.resignFirstResponder()
        }
    
    @IBAction func cancelButton(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
    
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

