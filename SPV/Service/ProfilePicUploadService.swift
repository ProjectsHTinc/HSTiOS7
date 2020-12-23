//
//  ProfilePicUploadService.swift
//  SPV
//
//  Created by HappySanz Tech on 10/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

class ProfilePicUploadService: NSObject {
    
    public func callAPIUserProfilePicUpdate(user_id:String, onSuccess successCallback: ((_ userProfilePicModel: UserProfilePicModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIUserProfilePicUpdate(
            user_id: user_id, onSuccess: { (userProfilePicModel) in
                successCallback?(userProfilePicModel)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
