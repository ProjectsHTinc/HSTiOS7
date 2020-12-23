//
//  profileService.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit


class ProfileDetailService: NSObject {
    
    public func callAPIUserProfileDetails(user_id:String, onSuccess successCallback: ((_ userProfileModel: UserProfileModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfileDetails(
            user_id: user_id, onSuccess: { (userProfileModel) in
                successCallback?(userProfileModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
