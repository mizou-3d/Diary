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
    
    let day_formatter: DateFormatter = DateFormatter()
    let time_formatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .dateAndTime
        
        self.navigationItem.title = "\(dateFormat(m_datepicker: datePicker))"
        
        datePicker.addTarget(self, action: #selector(changeTitle), for: .valueChanged)
        
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
            //キーボードを閉じる処理
        view.endEditing(true)
    }
    
    @objc func changeTitle(_ datePicker: UIDatePicker){
        self.navigationItem.title = "\(dateFormat(m_datepicker: datePicker))"
    }
    
    func dateFormat(m_datepicker: UIDatePicker) -> String{
        day_formatter.locale = Locale(identifier: "ja_JP")
        day_formatter.dateStyle = .full
        return day_formatter.string(from: m_datepicker.date)
    }
    func timeFormat(m_datepicker: UIDatePicker) -> String{
        time_formatter.locale = Locale(identifier: "ja_JP")
        time_formatter.timeStyle = .short
        return time_formatter.string(from: m_datepicker.date)
    }
    
    
    @IBAction func save(){
        let records = realm.objects(Record.self)
        let recordItem = Record()
        let contentItem = Content(value: ["hiduke": datePicker.date, "dateTime": timeFormat(m_datepicker: datePicker), "detailText": self.contentTextView.text!])
        
        if records.count < 1{
            recordItem.date = dateFormat(m_datepicker: datePicker)
            recordItem.listHiduke = datePicker.date
            recordItem.kibun = "mizo_clear"
            recordItem.contents.append(contentItem)
            try! realm.write{
                realm.add(recordItem)
            }
        } else {
            if let result = records.filter({$0.date == self.dateFormat(m_datepicker: self.datePicker)}).first{
                try! realm.write{
                    result.contents.append(contentItem)
                }
            }else{
                recordItem.date = dateFormat(m_datepicker: datePicker)
                recordItem.listHiduke = datePicker.date
                recordItem.kibun = "mizo_clear"
                recordItem.contents.append(contentItem)
                try! realm.write{
                    realm.add(recordItem)
                }
            }
        }
        
        let popoverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popoverVC")
        self.addChild(popoverVC)
        popoverVC.view.frame = self.view.frame
        self.view.addSubview(popoverVC.view)
        popoverVC.didMove(toParent: self)
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
    }
    
    @objc private func timerUpdate(){
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
