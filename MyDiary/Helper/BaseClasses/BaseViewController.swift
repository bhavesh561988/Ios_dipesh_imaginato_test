//
//  BaseViewController.swift
//  
//


import UIKit
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {
    
    private var returnHandler : IQKeyboardReturnKeyHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnHandler = IQKeyboardReturnKeyHandler(controller: self)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        //backItem.image = UIImage(named: "back_black")
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_black")
        self.navigationController?.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_black")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    class func controllerId() -> String {
        return String(describing:self)
    }
    
    
    @IBAction func showMenu(_ sender: Any) {
    }
    

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension BaseViewController{
    func storyBoard(type:StoryIdentifiers) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: nil)
    }
}
