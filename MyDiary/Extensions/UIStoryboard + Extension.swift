//
//  UIStoryboard + Extension.swift
//  Shophine
//
//  Created by PYTHON on 22/08/20.
//  Copyright © 2020 PYTHON. All rights reserved.
//

import Foundation
import UIKit


enum StoryIdentifiers:String{
    case main = "Main"
}

extension UIStoryboard{
    
    func instantiateVC<T: UIViewController>() -> T? {
        // get a class name and demangle for classes in Swift
        if let name = NSStringFromClass(T.self).split(separator: ".").last {
            return instantiateViewController(withIdentifier: String(name)) as? T
        }
        return nil
    }
    
}
