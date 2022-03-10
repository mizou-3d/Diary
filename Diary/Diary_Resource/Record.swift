//
//  Record.swift
//  Diary
//
//  Created by 溝手彩加 on 2022/03/07.
//

import Foundation
import RealmSwift

class Record: Object{
    @objc dynamic var recordCount: Int = 0
    @objc dynamic var kibun: String = ""
    @objc dynamic var dateTime: Date!
    @objc dynamic var detailText: String = ""
}
