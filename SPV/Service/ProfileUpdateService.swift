//
//  ProfileUpdateService.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

class ProfileUpdateService: NSObject {
    
    public func callAPIUserProfileUpdate(user_id:String,name:String,dob:String,phone:String,email:String,gender:String, onSuccess successCallback: ((_ userProfileUpdateModel: UserProfileUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfileUpdate(
            user_id: user_id,name:name,dob:dob,phone:phone,email:email,gender:gender, onSuccess: { (userProfileUpdateModel) in
                successCallback?(userProfileUpdateModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
