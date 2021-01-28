//
//  AwardsPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit



struct AwardsData {
    
     let awards_text_ta : String?
     let awards_text_en : String?
     let page_title_en : String?
     let page_title_ta : String?
}
protocol AwardsView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setAwardsValue(awardsRespResp: [AwardsData])
    func setEmpty(errorMessage:String)
}

class AwardsPresenter {
    
    private let awardsServices: AwardsServices
    weak private var awardsView : AwardsView?
    
    init(awardsServices:AwardsServices) {
        self.awardsServices = awardsServices
    }
    
    func attachView(view:AwardsView) {
        awardsView = view
    }
    
    func detachView() {
        awardsView = nil
    }

  func getAwardsValues(user_id:String) {
        
        self.awardsView?.startLoading()
        awardsServices.awardsAPI(
            user_id:user_id,  onSuccess: { (resp) in
                self.awardsView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return AwardsData(awards_text_ta: "\($0.awards_text_ta ?? "")", awards_text_en: "\($0.awards_text_en ?? "")", page_title_en: "\($0.page_title_en ?? "")", page_title_ta: "\($0.page_title_ta ?? "")")
                    }
                    self.awardsView?.setAwardsValue(awardsRespResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.awardsView?.finishLoading()
                self.awardsView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}


