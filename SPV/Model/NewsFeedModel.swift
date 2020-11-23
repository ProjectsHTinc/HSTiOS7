//
//  NewsFeedModel.swift
//  SPV
//
//  Created by Happy Sanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class NewsFeedModel: NSObject {
    
    var id : String?
    var category_name : String?
    var status : String?
   
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["id"] as? String {
             self.id = data
         }

        if let data = dict["category_name"] as? String {
            self.category_name = data
        }
        
        if let data = dict["status"] as? String {
            self.status = data
        }
        
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> NewsFeedModel {
         let model = NewsFeedModel()
         model.loadFromDictionary(dict)
         return model
     }

}
