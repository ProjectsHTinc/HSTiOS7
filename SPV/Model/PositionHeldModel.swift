//
//  PositionHeldModel.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation


class PositionHeldModel {

    var position_text_en : String?
    var position_text_ta : String?
    var title_en : String?
    var title_ta : String?
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["position_text_en"] as? String {
             self.position_text_en = data
         }
         if let data = dict["position_text_ta"] as? String {
             self.position_text_ta = data
         }
         if let data = dict["title_en"] as? String {
             self.title_en = data
         }
         if let data = dict["title_ta"] as? String {
            self.title_ta = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> PositionHeldModel {
         let model = PositionHeldModel()
         model.loadFromDictionary(dict)
         return model
     }

}
