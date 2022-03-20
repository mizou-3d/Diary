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
    var recordItems: Results<Record>!
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var ureButton: UIButton!
    @IBOutlet var maButton: UIButton!
    @IBOutlet var iyaButton: UIButton!
    @IBOutlet var kanaButton: UIButton!
    @IBOutlet var timeTable: UITableView!
    
    var dateFilter: String = ""
    var sectionIndex: Int = 0
    
    let shadowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeBtnDesign(button: ureButton)
        changeBtnDesign(button: maButton)
        changeBtnDesign(button: iyaButton)
        changeBtnDesign(button: kanaButton)

        dayLabel.text = dateFilter
        let results = realm.objects(Record.self)
        print(results[sectionIndex].contents.count)
        
        timeTable.delegate = self
        timeTable.dataSource = self
        timeTable.layer.cornerRadius = 30
//        timeTable.clipsToBounds = true
//        shadowView.layer.cornerRadius = 10
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowRadius = 4
//        shadowView.layer.masksToBounds = false
//
//            // viewに追加
//        self.view.addSubview(shadowView)
//        self.view.bringSubviewToFront(timeTable)
        
        ureButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        ureButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        maButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        maButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        iyaButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        iyaButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        kanaButton.addTarget(self, action: #selector(self.pushButton_Animation(_:)), for: .touchDown)
        kanaButton.addTarget(self, action: #selector(self.separateButton_Animation(_:)), for: .touchUpInside)
        
        timeTable.layer.shadowColor = UIColor.black.cgColor
        timeTable.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        timeTable.layer.shadowOpacity = 0.5
        timeTable.layer.shadowRadius = 4
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // サイズ合わせる
        shadowView.frame = timeTable.frame
    }
    
    @objc func pushButton_Animation(_ sender: UIButton){
        UIView.animate(withDuration: 0.1, animations:{ () -> Void in
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    @objc func separateButton_Animation(_ sender: UIButton){
        UIView.animate(withDuration: 0.2, animations:{ () -> Void in
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
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
        let results = realm.objects(Record.self)
        let cell: DayTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DayTableViewCell
        let sortData = results[sectionIndex].contents.sorted(byKeyPath: "hiduke", ascending: true)
        cell.timeLabel.text = sortData[indexPath.row].dateTime
        cell.contentLabel.text = sortData[indexPath.row].detailText
        cell.contentBackground.layer.cornerRadius = 10
        cell.contentBackground.layer.masksToBounds = true
        return cell
    }
    
    @IBAction func tapUre(){
        updateKibun(kibun: "mizo_ure")
        print("ureshi")
    }
    @IBAction func tapMa(){
        updateKibun(kibun: "mizo_ma")
        print("ma-ma-")
    }
    @IBAction func tapIya(){
        updateKibun(kibun: "mizo_iya")
        print("iyada")
    }
    @IBAction func tapKana(){
        updateKibun(kibun: "mizo_kana")
        print("kanashi")
    }
    
    @objc private func updateKibun(kibun: String){
        let results = realm.objects(Record.self)
        try! realm.write{
            results[sectionIndex].kibun = kibun
        }
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
