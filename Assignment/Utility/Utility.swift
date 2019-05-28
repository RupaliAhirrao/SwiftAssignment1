//
//  Utility.swift
//  Assignment
//
//  Created by test on 28/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    //calculate height for label with dynamic text
    class func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label = UILabel()
        label.frame.size = CGSize(width: width, height:CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
