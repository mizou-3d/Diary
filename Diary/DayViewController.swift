//
//  DayViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/06.
//

import UIKit
import RealmSwift

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    let recordItem: Record = Record()
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var ureButton: UIButton!
    @IBOutlet var maButton: UIButton!
    @IBOutlet var iyaButton: UIButton!
    @IBOutlet var kanaButton: UIButton!
    @IBOutlet var timeTable: UITableView!
    
    var dateFilter: String = ""
    var sectionIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeBtnDesign(button: ureButton)
        changeBtnDesign(button: maButton)
        changeBtnDesign(button: iyaButton)
        changeBtnDesign(button: kanaButton)

        dayLabel.text = dateFilter
        //let predicate = NSPredicate(format: "date == %@", dateFilter)
        //let results = realm.objects(Record.self).filter(predicate)
        let results = realm.objects(Record.self)
        print(results[sectionIndex].contents.count)
        
        timeTable.delegate = self
        timeTable.dataSource = self
    }
    
    @objc private func changeBtnDesign(button: UIButton){
        button.layer.shadowColor = UIColor(named: "navy")?.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.7)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let predicate = NSPredicate(format: "date == %@", dateFilter)
//        let results = realm.objects(Record.self).filter(predicate)
        let results = realm.objects(Record.self)
        return results[sectionIndex].contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let predicate = NSPredicate(format: "date == %@", dateFilter)
        let results = realm.objects(Record.self).filter(predicate)//.sorted(byKeyPath: "hiduke", ascending: true)
        let cell: DayTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DayTableViewCell
        cell.timeLabel.text = results[indexPath.section].contents[indexPath.row].dateTime
        cell.contentLabel.text = results[indexPath.section].contents[indexPath.row].detailText
        cell.contentBackground.layer.cornerRadius = 10
        cell.contentBackground.layer.masksToBounds = true
        return cell
    }
    
    @IBAction func tapUre(){
        recordItem.kibun = "mizo_ure"
        print("ureshi")
    }
    @IBAction func tapMa(){
        recordItem.kibun = "mizo_ma"
        print("ma-ma-")
    }
    @IBAction func tapIya(){
        recordItem.kibun = "mizo_iya"
        print("iyada")
    }
    @IBAction func tapKana(){
        recordItem.kibun = "mizo_kana"
        print("kanashi")
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
