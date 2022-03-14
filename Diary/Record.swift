//
//  Record.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/07.
//

import Foundation
import RealmSwift
import UIKit

class Record: Object{
    @objc dynamic var recordCount: Int = 0
    @objc dynamic var kibun: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var hiduke: Date!
    @objc dynamic var dateTime: String = ""
    @objc dynamic var detailText: String = ""
    
//    override static func primaryKey() -> String? {
//        return "date"
//    }
}

