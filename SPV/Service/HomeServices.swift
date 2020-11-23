//
//  HomeServices.swift
//  OPS
//
//  Created by Happy Sanz Tech on 03/10/20.
//

import UIKit

class HomeServices {
    
    public func homeAPI (from:String, search_text:String, categoery:String, nf_category_id:String, offset:String, rowcount:String,onSuccess successCallback: ((_ resp: [HomeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.homeAPI(
            from:from, search_text:search_text, categoery:categoery, nf_category_id:nf_category_id, offset:offset, rowcount:rowcount, onSuccess: { (resp) in
                successCallback?(resp)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
