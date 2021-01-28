//
//  NotableWorksModel.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation



class NotableWorksModel {

    var noteable_text_ta : String?
    var noteable_text_en : String?
    var title_en : String?
    var title_ta : String?
   
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["noteable_text_ta"] as? String {
             self.noteable_text_ta = data
         }
         if let data = dict["noteable_text_en"] as? String {
             self.noteable_text_en = data
         }
         if let data = dict["title_en"] as? String {
             self.title_en = data
         }
         if let data = dict["title_ta"] as? String {
            self.title_ta = data
        }
       
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> NotableWorksModel {
         let model = NotableWorksModel()
         model.loadFromDictionary(dict)
         return model
     }

}
