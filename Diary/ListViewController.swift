//
//  ListViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/06.
//

import UIKit
import RealmSwift
import SwiftUI

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTable: UITableView!
    @IBOutlet var addButton: UIButton!

    var recordItems: Results<Record>!
    //var contentItems: Record = Record()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "",
        style: .plain,
        target: nil,
        action: nil
        )
        
        let realm = try! Realm()
        self.recordItems = realm.objects(Record.self)
        listTable.reloadData()

        listTable.delegate = self
        listTable.dataSource = self
        addButton.layer.cornerRadius = 40
        self.view.bringSubviewToFront(addButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell
        //let item: Record = recordItems[indexPath.row]
        cell.timeLabel.text = recordItems[indexPath.row].dateTime
        cell.contentLabel.text = recordItems[indexPath.row].detailText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(recordItems[indexPath.row].date) is selected.")
        let dayView = storyboard?.instantiateViewController(withIdentifier: "dayViewController") as! DayViewController
        dayView.dateFilter =  "\(recordItems[indexPath.row].date)"
        //performSegue(withIdentifier: "toGoDayRecord", sender: nil)
        self.navigationController?.pushViewController(dayView, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toGoDayRecord" {
//            let dayView = segue.destination as! DayViewController
//            dayView.dateFilter = selectedDay
//        }
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return recordItems.count
//    }
//    func tableview(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//        return recordItems[section].date
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return recordItems.count
//    }
//
//    //Mark: ヘッダーの大きさを設定する
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
//
//        return 50
//    }
//
//    //Mark: ヘッダーに設定するViewを設定する
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//
//        //ヘッダーにするビューを生成
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
//
//        //ヘッダーに追加するラベルを生成
//        let headerLabel = UILabel()
//        let item: Record = recordItems[section]
//        headerLabel.frame =  CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 50)
//        headerLabel.text = item.date
//        headerLabel.textAlignment = NSTextAlignment.center
//        view.addSubview(headerLabel)
//
//        return view
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
