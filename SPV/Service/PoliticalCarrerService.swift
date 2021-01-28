//
//  PoliticalCarrerService.swift
//  SPV
//
//  Created by HappySanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation

class PoliticalCarrerSerVice {
    
    public func callAPIPoliticalCarrer (user_id:String,onSuccess successCallback: ((_ resp: [PoliticalCarrerModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPoliticalCarrer(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
