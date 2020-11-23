//
//  NewsFeedServices.swift
//  SPV
//
//  Created by Happy Sanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class NewsFeedServices: NSObject {
    
    public func callNewsFeed(user_id:String,onSuccess successCallback: ((_ newsFeedData: [NewsFeedModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callNewsFeed(
            user_id: user_id, onSuccess: { (newsFeedData) in
                successCallback?(newsFeedData)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
