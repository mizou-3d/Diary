//
//  AddViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/06.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet var contentTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func save(){
        let realm2 = try! Realm()
        let recordItem: Record = Record()
        //recordItem.date = self.datePicker.text
        //recordItem.detailText = self.contentTextView.text
        try! realm2.write{
            realm2.add(recordItem)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        // 入力を反映させたテキストを取得する
//        let resultText: String = (textView.text! as NSString).replacingCharacters(in: range, with: text)
//        if resultText.count <= 50 {
//            return true
//        }
//        return false
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
