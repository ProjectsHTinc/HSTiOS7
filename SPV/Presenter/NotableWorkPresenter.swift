//
//  NotableWorkPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation

struct NotableWorksData {
    
     let noteable_text_ta : String?
     let noteable_text_en : String?
     let title_en : String?
     let title_ta : String?
}
protocol NotableWorksView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setNotableWorksValue(notableWorkspResp: [NotableWorksData])
    func setEmpty(errorMessage:String)
}

class NotableWorksPresenter {
    
    private let notableWorksServices: NotableWorksServices
    weak private var notableWorksView : NotableWorksView?
    
    init(notableWorksServices:NotableWorksServices) {
        self.notableWorksServices = notableWorksServices
    }
    
    func attachView(view:NotableWorksView) {
        notableWorksView = view
    }
    
    func detachView() {
        notableWorksView = nil
    }

  func getnotableWorksValues(user_id:String) {
        
        self.notableWorksView?.startLoading()
        notableWorksServices.notableWorksAPI(
            user_id:user_id,  onSuccess: { (resp) in
                self.notableWorksView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return NotableWorksData(noteable_text_ta: "\($0.noteable_text_ta ?? "")", noteable_text_en: "\($0.noteable_text_en ?? "")", title_en: "\($0.title_en ?? "")", title_ta: "\($0.title_ta ?? "")")
                    }
                    self.notableWorksView?.setNotableWorksValue(notableWorkspResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.notableWorksView?.finishLoading()
                self.notableWorksView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}


