//
//  StringExtensions.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import Foundation

extension String {
    
    static func makeSlashText(_ text:String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
}
