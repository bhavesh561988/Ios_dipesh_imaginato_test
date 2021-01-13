//
//  EditNotesViewController.swift
//  My Dairy
//
//  Created by 46tech on 06/12/20.
//

import UIKit
import RxSwift

class EditNotesViewController: BaseViewController {

    @IBOutlet weak var txtEditTitle: UITextField!
    @IBOutlet weak var txtEditContent: UITextView!

    var note = NotesData()
    
    //A publish subject to observe the updated note's content and title
    private let noteModifiedSubject = PublishSubject<NotesData>()
        var noteModified: Observable<NotesData>{
            return noteModifiedSubject.asObserver()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = note.title
        self.txtEditTitle.text = note.title
        self.txtEditContent.text = note.content
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let updatedNote = DatabaseHelper.shared.update(note: note, newTitle: txtEditTitle.text ?? "", newContent: txtEditContent.text)
        noteModifiedSubject.onNext(updatedNote) //onNext method will send the next event to its subscribers
        self.navigationController?.popViewController(animated: true)
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
