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
    
    @IBOutlet var zeroImg: UIImageView!
    @IBOutlet var zeroLabel: UILabel!

    let realm = try! Realm()
    var recordItems: Results<Record>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "",
        style: .plain,
        target: nil,
        action: nil
        )
        self.recordItems = realm.objects(Record.self).sorted(byKeyPath: "listHiduke", ascending: false)
        print(recordItems)
        //recordItems = realm.objects(Record.self)
        listTable.reloadData()
        
        //recordItems = realm.objects(Record.self)
        if recordItems.count > 0 {
            zeroImg.isHidden = true
            zeroLabel.isHidden = true
        }
        
        let nib = UINib(nibName: "CustomHeaderView", bundle: nil)
        listTable.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderView")

        listTable.delegate = self
        listTable.dataSource = self
        listTable.sectionHeaderHeight = 60
        
        addButton.layer.cornerRadius = 40
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.5
        addButton.layer.shadowRadius = 3.0
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        self.view.bringSubviewToFront(addButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recordItems = realm.objects(Record.self).sorted(byKeyPath: "listHiduke", ascending: false)
        print(recordItems)
        //recordItems = realm.objects(Record.self)
        if recordItems.count > 0 {
            zeroImg.isHidden = true
            zeroLabel.isHidden = true
        }
        listTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contentItems = realm.objects(Record.self).sorted(byKeyPath: "listHiduke", ascending: false)
        return contentItems[section].contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.recordItems = realm.objects(Record.self).sorted(byKeyPath: "listHiduke", ascending: false)
        let cell: ListTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell
        let sortData = recordItems[indexPath.section].contents.sorted(byKeyPath: "hiduke", ascending: true)
        cell.timeLabel.text = sortData[indexPath.row].dateTime
        cell.contentLabel.text = sortData[indexPath.row].detailText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(recordItems[indexPath.row].date) is selected.")
        let dayView = storyboard?.instantiateViewController(withIdentifier: "dayViewController") as! DayViewController
        dayView.dateFilter =  "\(recordItems[indexPath.section].date)"
        dayView.sectionIndex = indexPath.section
        print("section: \(indexPath.section), row: \(indexPath.row)")
        self.navigationController?.pushViewController(dayView, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        recordItems = realm.objects(Record.self)
        return recordItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.recordItems = realm.objects(Record.self).sorted(byKeyPath: "listHiduke", ascending: false)
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")
        if let headerView = view as? HeaderView {
            headerView.setup(image: UIImage(named: "\(recordItems[section].kibun).png")! , title: recordItems[section].date)
            headerView.backgroundColor = UIColor(named: "purple")
        }
        return view
    }
    
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
