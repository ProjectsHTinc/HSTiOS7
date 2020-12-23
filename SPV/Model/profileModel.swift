//
//  profileModel.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class UserProfileModel: NSObject {
    
    var user_id: String?
    var full_name : String?
    var phone_number : Int?
    var email_id : String?
//    var gender : String?
    var dob : String?
    var profile_pic : String?


    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
//       if let data = dict["id"] as? String {
//            self.user_id = data
//        }
        if let data = dict["full_name"] as? String {
            self.full_name = data
        }
        if let data = dict["phone_number"] as? Int {
            self.phone_number = data
        }
        if let data = dict["email_id"] as? String {
            self.email_id = data
        }
        if let data = dict["dob"] as? String {
            self.dob = data
        }
//        if let data = dict["gender"] as? String {
//            self.gender = data
//        }
        if let data = dict["profile_pic"] as? String {
            self.profile_pic = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> UserProfileModel {
        let userProfileModel = UserProfileModel()
        userProfileModel.loadFromDictionary(dict)
        return userProfileModel
    }

}
