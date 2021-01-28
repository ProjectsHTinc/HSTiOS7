//
//  AwardsModel.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


class AwardsModel {

    var page_title_en : String?
    var page_title_ta : String?
    var awards_text_en : String?
    var awards_text_ta : String?
   
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["page_title_en"] as? String {
             self.page_title_en = data
         }
         if let data = dict["page_title_ta"] as? String {
             self.page_title_ta = data
         }
         if let data = dict["awards_text_en"] as? String {
             self.awards_text_en = data
         }
         if let data = dict["awards_text_ta"] as? String {
            self.awards_text_ta = data
        }
       
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> AwardsModel {
         let model = AwardsModel()
         model.loadFromDictionary(dict)
         return model
     }

}
