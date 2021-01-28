//
//  PersonalLifeServices.swift
//  SPV
//
//  Created by Happy Sanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class PersonalLifeSerVice {
    
    public func callAPIPersonalLife (user_id:String,onSuccess successCallback: ((_ resp: [PersonalLifeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPersonalLife(
            user_id:user_id, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}
