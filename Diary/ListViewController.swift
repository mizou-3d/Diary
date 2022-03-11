//
//  ListViewController.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/06.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var listTable: UITableView!
    @IBOutlet var addButton: UIButton!

    var recordItems: Results<Record>!

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
        let cell = listTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item: Record = recordItems[indexPath.row]
        cell.textLabel?.text = item.date
        //cell.detailTextLabel?.text = item.detailText
        return cell
    }
    
    var startingFrame: CGRect!
    var endingFrame: CGRect!
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) && self.addButton.isHidden {
//            self.addButton.isHidden = false
//            self.addButton.frame = startingFrame
//            UIView.animate(withDuration: 1.0){
//                self.addButton.frame = self.endingFrame
//            }
//        }
//    }
    
    func configureSizes(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        startingFrame = CGRect(x: 0, y: screenHeight+100, width: screenWidth, height: 100)
        endingFrame = CGRect(x: 0, y: screenHeight-100, width: screenWidth, height: 100)
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
