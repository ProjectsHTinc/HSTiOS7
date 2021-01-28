//
//  NotableWorksService.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


class NotableWorksServices {
    
    public func notableWorksAPI (user_id:String,onSuccess successCallback: ((_ resp: [NotableWorksModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.notableWorksAPI(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
