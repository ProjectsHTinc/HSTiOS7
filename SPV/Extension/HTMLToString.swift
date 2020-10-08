//
//  HTMLToString.swift
//  SPV
//
//  Created by HappySanz Tech on 07/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func stringFromHtml(string: String) -> NSAttributedString? {
       do {
           let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
           if let d = data {
               let str = try NSAttributedString(data: d,
                                                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                documentAttributes: nil)
               return str
           }
       } catch {
       }
       return nil
    }
}


extension UILabel {
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>" as NSString, text)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue,],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
}
