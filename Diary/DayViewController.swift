//
//  DayViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/06.
//

import UIKit
import RealmSwift

class DayViewController: UIViewController {
    
    let realm = try! Realm()
    let recordItem: Record = Record()
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var ureButton: UIButton!
    @IBOutlet var maButton: UIButton!
    @IBOutlet var iyaButton: UIButton!
    @IBOutlet var kanaButton: UIButton!
    @IBOutlet var timeTable: UITableView!
    
    var dateFilter: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        dayLabel.text = dateFilter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dayLabel.text = dateFilter
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
