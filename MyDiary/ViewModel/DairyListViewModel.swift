//
//  DairyListViewModel.swift
//  RealmDemo
//
//  Created by 46tech on 04/12/20.
//

import Foundation
import RxSwift

final class DairyListViewModel {
    private let dairyService: SendDairyData

    private(set) var sectionTitles = [String]()
    private(set) var allNotes = [NoteSectionModel]()
    
    init(dairyService: SendDairyData = DairyService()) {
        self.dairyService = dairyService
    }
    
    //Observable method to fill section model
    func fetchDairyViewModels() -> Observable<[NoteSectionModel]> {
        if isNotesDataAvailableLocally() == false {
            return dairyService.fetchDairyData().map({

                let dairyViewModels = $0.map {
                    DairyViewModel(notes: $0)
                }

                DispatchQueue.main.async {
                    self.addDairyViewModelsToDB(dairyViewModels)
                }
                
                //Set data into Database model.
                var notes = [NotesData]()
                for dairyViewModel in dairyViewModels {
                    let note = NotesData()
                    note.id = dairyViewModel.noteID
                    note.title = dairyViewModel.noteTitle
                    note.content = dairyViewModel.noteContent
                    note.date = dairyViewModel.noteDate.toDate()?.date ?? Date()

                    notes.append(note)
                }

                notes.sort(by: { (lhsNote, rhsNote) -> Bool in
                    lhsNote.date > rhsNote.date
                })

                self.allNotes = self.getNoteSections(notesData: notes)
                return self.allNotes
            })
        }

        self.allNotes = getNoteSections(notesData: getNotesDataFromDB())
        return Observable.from(optional: self.allNotes)
    }

    private func isNotesDataAvailableLocally() -> Bool {
        getNotesDataFromDB().count > 0
    }
    
    //Get notes data from the DB
    private func getNotesDataFromDB() -> [NotesData] {
        DatabaseHelper.shared.getNotes()
    }
    
    //Add data model object into DB.
    private func addDairyViewModelsToDB(_ dairyViewModels: [DairyViewModel]) {
        for dairyViewModel in dairyViewModels {
            DatabaseHelper.shared.addNewNote(dairyViewModel: dairyViewModel)
        }
    }
    
    //Filter notes section based on upon date added from.
    private func getNoteSections(notesData: [NotesData]) -> [NoteSectionModel] {
        var notes = [String: [NotesData]]()

        for note in notesData {
            var keyName = String()

            let noteDate = note.date
            if noteDate.compare(.isToday) {
                keyName = "Today"
            }else if noteDate.compare(.isYesterday){
                keyName = "Yesterday"
            }else if noteDate.compare(.isThisWeek){
                keyName = noteDate.weekdayName(.default)
            }else if noteDate.compare(.isThisMonth){
                keyName = "This Month"
            }else if noteDate.compare(.isThisYear){
                keyName = noteDate.monthName(.default)
            }else{
                keyName = noteDate.year.description
            }

            if let _ = notes[keyName] {
                notes[keyName]?.append(note)
            } else {
                notes[keyName] = [note]
                self.sectionTitles.append(keyName)
            }
        }

        return notes.map { (note) -> NoteSectionModel in
            let (_, value) = note
            return NoteSectionModel.NotesSection(notes: value)
        }.sorted { (lhsNoteSectionModel, rhsNoteSectionModel) -> Bool in
            lhsNoteSectionModel.items.first!.date > rhsNoteSectionModel.items.first!.date
        }
    }
}
