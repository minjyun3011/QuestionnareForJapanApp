//
//  ItemTableViewController.swift
//  QuestionnareForJapanApp
//
//  Created by 佐藤壮 on 2023/09/14.
//

import UIKit
import Firebase

class ItemTableViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var travelNum: String?
    
    
    @IBOutlet weak var itemCell: UITableViewCell!
    //
    @IBOutlet weak var imageView: UIImageView!
    
    var questions: [String] = ["Prefecture Visited", "Food(What You Ate There)", "Locations (Where You Went To)", "Accommodations(Where You stayed)", "Means of Transportation", "Travel Troubles","Differences You Noticed Between Your Country and Japan", "Souvenirs You Bought", "Reactions from Your Acquaintances", "Your Experiences in Japan","Your Most Impressive Experience", "What are Hopes for Your Next Japan trip?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(travelNum)
        let userDefaults = UserDefaults.standard
        userDefaults.object(forKey: "questions")
        //キー"add"で配列をUserDefaultsに保存
        
        //        UserDefaults.standard.set(itemCell.text, forKey: "itemCell")
        
        //        アイコンも一時的に保存
        //        画像データを10分の1に圧縮
        //        let data = imageView.image?.jpegData(compressionQuality: 0.1)
        //        UserDefaults.standard.set(data, forKey: "userImage")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        // indexPathを使用して選択されたセルに関連するデータを取得します
        
        // 遷移先のビューコントローラをインスタンス化します
        //        let goToInput = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "inputViewController") as! InputViewController
        let inputVC = self.storyboard?.instantiateViewController(identifier: "inputViewController") as! InputViewController
        self.navigationController?.pushViewController(inputVC, animated: true)
        
    }
    //    @IBAction func tapImageView(_ sender: Any) {
    //        showAlert()
    //    }
    
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
    
    
    /* 追加 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputVC = self.storyboard?.instantiateViewController(identifier: "inputViewViewController") as! InputViewController
        inputVC.questionNum = questions[indexPath.row]
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
    
}

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

