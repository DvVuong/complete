//
//  ListCellViewModel.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import Foundation
import UIKit
final class ListCellViewModel {
    
    init() {}
    
    func setHigLight(_ search: String, text: String) -> NSAttributedString {
        let range = (text.uppercased() as NSString).range(of: search.uppercased())
        let mutableAttrinbutedString = NSMutableAttributedString.init(string: text)
        mutableAttrinbutedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        return mutableAttrinbutedString
    }
    
}
