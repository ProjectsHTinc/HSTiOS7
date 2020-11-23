//
//  SocialMediaService.swift
//  SPV
//
//  Created by Happy Sanz Tech on 12/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class SocialMediaService: NSObject {
    
    public func callSocilaMedia(user_id:String,onSuccess successCallback: ((_ socilaMedia: [SocilaMediaModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callSocilaMedia(
            user_id: user_id, onSuccess: { (socilaMedia) in
                successCallback?(socilaMedia)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
