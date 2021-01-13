//
//  NotesSection.swift
//  My Dairy
//
//  Created by 46tech on 07/12/20.
//

import RxDataSources

enum NoteSectionModel {
    case NotesSection(notes: [NotesData])
}

extension NoteSectionModel: SectionModelType {
    typealias Item = NotesData

    var items: [NotesData] {
        switch  self {
        case .NotesSection(notes: let items):
            return items.map { $0 }
        }
    }

    init(original: NoteSectionModel, items: [Item]) {
        switch original {
        case .NotesSection(notes: _):
            self = .NotesSection(notes: items)
        }
    }
}
