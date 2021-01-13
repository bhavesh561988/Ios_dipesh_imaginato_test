//
//  NotesData.swift
//  RealmDemo
//
//  Created by 46tech on 04/12/20.
//

import UIKit
import Realm
import RealmSwift

class NotesData: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var date = Date()
}
