//
//  BaseTableViewCell.swift
//
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class func cellID() -> String {
        return String(describing: self)
    }
    
    class func heightForCell() -> CGFloat {
        return 44.0;
    }
    
    func setup<T>(_ object: T){
    }

}
