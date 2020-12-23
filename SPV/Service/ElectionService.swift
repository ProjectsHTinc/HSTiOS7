//
//  ElectionService.swift
//  SPV
//
//  Created by HappySanz Tech on 23/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


class ElectionServices {
    
    public func electionAPI (user_id:String,onSuccess successCallback: ((_ resp: [ElectionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.electionAPI(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
