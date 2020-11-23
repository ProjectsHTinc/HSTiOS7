//
//  SocilaMediaModel.swift
//  SPV
//
//  Created by Happy Sanz Tech on 12/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class SocilaMediaModel: NSObject {
    
    var id : String?
    var sm_title : String?
    var sm_url : String?
    var status : String?
    var created_by : String?
    var created_at : String?
    var updated_by : String?
    var updated_at : String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["id"] as? String {
            self.id = data
        }

       if let data = dict["sm_title"] as? String {
           self.sm_title = data
       }
       
       if let data = dict["sm_url"] as? String {
           self.sm_url = data
       }
        
       if let data = dict["status"] as? String {
            self.status = data
       }
        
       if let data = dict["created_by"] as? String {
            self.created_by = data
       }
        
       if let data = dict["created_at"] as? String {
            self.created_at = data
       }
        
       if let data = dict["updated_by"] as? String {
            self.updated_by = data
       }
        
       if let data = dict["updated_at"] as? String {
            self.updated_at = data
       }
       
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> SocilaMediaModel {
        let model = SocilaMediaModel()
        model.loadFromDictionary(dict)
        return model
    }

}
