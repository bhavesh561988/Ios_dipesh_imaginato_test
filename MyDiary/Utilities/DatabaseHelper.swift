//
//  DatabaseHelper.swift
//  MyDiary
//
//  Created by 46tech on 07/12/20.
//

import Foundation
import RealmSwift

class DatabaseHelper {
    static let shared = DatabaseHelper()

    let realm = try! Realm()
    
    //Get notes from the Database.
    func getNotes() -> [NotesData] {
        return Array(realm.objects(NotesData.self).sorted(byKeyPath: "date", ascending: false))
    }
    
    //Add new notes data into Database.
    func addNewNote(dairyViewModel: DairyViewModel) {
        try! realm.write {
            let note = NotesData()

            note.id = dairyViewModel.noteID
            note.title = dairyViewModel.noteTitle
            note.content = dairyViewModel.noteContent
            note.date = dairyViewModel.noteDate.toDate()?.date ?? Date()

            realm.add(note)
        }
    }
    
    //Update notes object into Database.
    func update(note: NotesData, newTitle: String, newContent: String) -> NotesData {
           try! realm.write {
               note.title = newTitle
               note.content = newContent
               note.date = Date()
           }
           return note
    }

    //To remove all the data from the DB.
    func removeAllData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
