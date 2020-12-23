//
//  profileUpdate.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

class UserProfileUpdateModel: NSObject {
    
    var status: String?
    var msg: String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["msg"] as? String {
            self.msg = data
        }
 
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserProfileUpdateModel {
        let userProfileUpdateModel = UserProfileUpdateModel()
        userProfileUpdateModel.loadFromDictionary(dict)
        return userProfileUpdateModel
    }

}
