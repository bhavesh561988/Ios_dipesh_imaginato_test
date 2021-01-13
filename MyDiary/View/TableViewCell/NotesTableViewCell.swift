//
//  NotesTableViewCell.swift
//  My Dairy
//
//  Created by 46tech on 05/12/20.
//

import UIKit
import RxSwift
import RxDataSources
import SwiftDate

protocol SendEditNotesData{
    func sendNotesData(sender: UIButton, section:Int)
}

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnEdit: UIButton!

    var note = NotesData()
    
    var editNotesDelegate:SendEditNotesData!
    
    let dataSource: [String: [DairyViewModel]] = [:]
    
    var notesData:NotesData!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        setShaddow(view: bgView)
        // Initialization code
    }
    
    func setup(forNote note: NotesData) {
        print(note.title)
        self.note = note
        lblTitle.text = note.title
        lblContent.text = note.content
        let noteDate = note.date
        if noteDate.compare(.isToday) {
            lblTime.text = "\(note.date.hour.description) hours ago"
        }else if noteDate.compare(.isYesterday){
            lblTime.text = "\(note.date.hour.description) hours ago"
        }else if noteDate.compare(.isThisWeek){
            lblTime.text = "\(note.date.weekOfMonth.description) weeks ago"
        }else if noteDate.compare(.isThisMonth){
            lblTime.text = "\(note.date.weekOfYear.description) weeks ago"
        }else if noteDate.compare(.isThisYear){
            lblTime.text = "\(note.date.weekOfYear.description) weeks ago"
        }else{
            lblTime.text = "\(note.date.weekOfYear.description) weeks ago"
        }

    }
    
    func setShaddow(view: UIView){
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.13
        view.layer.shadowRadius = 4.0
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditNotesViewController") as! EditNotesViewController
        vc.modalPresentationStyle = .custom
        vc.note = self.note
        let controller = self.parentContainerViewController() as! NotesListViewController
        
        vc.noteModified.subscribe(onNext: { [weak self] note in
            DispatchQueue.main.async {
                controller.notesTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
            }
        }).disposed(by: controller.disposeBag)
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        
    }
    
    
}
