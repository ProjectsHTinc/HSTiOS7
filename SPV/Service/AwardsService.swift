//
//  AwardsService.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


class AwardsServices {
    
    public func awardsAPI (user_id:String,onSuccess successCallback: ((_ resp: [AwardsModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.awardsAPI(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
