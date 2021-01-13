//
//  NotesListViewController.swift
//  My Diary
//
//  Created by 46tech on 07/12/20.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import RxDataSources
import SwiftDate

class NotesListViewController: BaseViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var viewModel: DairyListViewModel!

    var sectionTitles = [String]()
    var diaryNotes:[DairyViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //Get data source using RxDataSource methods from the section models.
        let dataSource = NotesListViewController.dataSource()
        
        //Fetch notes from the ViewModel and bind them into tableview using RxDataSource.
        viewModel.fetchDairyViewModels()
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: notesTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Initiate viewmodel and data setup.
    static func instantiate(viewModel: DairyListViewModel) -> NotesListViewController{
        let storyboard1 = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard1.instantiateViewController(withIdentifier: "NotesListViewController") as! NotesListViewController
        viewController.viewModel = viewModel
        return viewController
        
    }
    
    //TableViewSetup
    func setupTableView(){
        notesTableView.delegate = self
        notesTableView.separatorStyle = .none
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
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

//RxDataSource Methods
extension NotesListViewController{
    static func dataSource() -> RxTableViewSectionedReloadDataSource<NoteSectionModel> {
        return RxTableViewSectionedReloadDataSource<NoteSectionModel>(
            configureCell: { dataSource, table, indexPath, _ in
                let cell = table.dequeueReusableCell(withIdentifier: "NotesTableViewCell")! as! NotesTableViewCell
                cell.setup(forNote: dataSource[indexPath])
                cell.btnEdit.tag = indexPath.row
                return cell
            }
        )
    }
}

//TableView Delegate Methods
extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("HeaderViewTableViewCell", owner: self, options: nil)![0] as! HeaderViewTableViewCell
        header.setTitle(title: viewModel.sectionTitles[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
}
