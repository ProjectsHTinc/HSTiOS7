//
//  PositionHeldService.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class PositionHeldServices {
    
    public func electionAPI (user_id:String,onSuccess successCallback: ((_ resp: [PositionHeldModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.positionHeldAPI(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
