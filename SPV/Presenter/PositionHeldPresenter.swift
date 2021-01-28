//
//  PositionHeldPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


struct PositionHeldData {
    
     let position_text_en : String?
     let position_text_ta : String?
     let title_en : String?
     let title_ta : String?
}
protocol PostionHeldView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setElectionHeldValue(positionResp: [PositionHeldData])
    func setEmpty(errorMessage:String)
}

class PositionHeldPresenter {
    
    private let positionheldServices: PositionHeldServices
    weak private var positionHeldView : PostionHeldView?
    
    init(positionheldServices:PositionHeldServices) {
        self.positionheldServices = positionheldServices
    }
    
    func attachView(view:PostionHeldView) {
        positionHeldView = view
    }
    
    func detachView() {
        positionHeldView = nil
    }

  func getPositionHeldValues(user_id:String) {
        
        self.positionHeldView?.startLoading()
        positionheldServices.electionAPI(
            user_id:user_id,  onSuccess: { (resp) in
                self.positionHeldView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return PositionHeldData(position_text_en: "\($0.position_text_en ?? "")", position_text_ta: "\($0.position_text_ta ?? "")", title_en: "\($0.title_en ?? "")", title_ta: "\($0.title_ta ?? "")")
                    }
                    self.positionHeldView?.setElectionHeldValue(positionResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.positionHeldView?.finishLoading()
                self.positionHeldView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}

