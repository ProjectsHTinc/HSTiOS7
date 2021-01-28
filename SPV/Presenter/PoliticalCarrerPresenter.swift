//
//  PoliticalCarrerPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation


struct PoliticalCarrerData {
    
    let political_career_text_ta : String?
    let political_career_text_en: String?
    
}

protocol PoliticalCarrerView : NSObjectProtocol {
    func startLoadingTg()
    func finishLoadingTg()
    func setPoliticalValue(poliResp: [PoliticalCarrerData])
    func setEmptyPc(errorMessage:String)
}

class PoliticalCarrerPresenter: NSObject {
    
    private let politicalCarrerSerVice: PoliticalCarrerSerVice
    weak private var politicalCarrerView : PoliticalCarrerView?
    
    init(politicalCarrerSerVice:PoliticalCarrerSerVice) {
        self.politicalCarrerSerVice = politicalCarrerSerVice
    }
    
    func attachView(view:PoliticalCarrerView) {
        politicalCarrerView = view
    }
    
    func detachView() {
        politicalCarrerView = nil
    }
    
    func getPoliticalValues(user_id:String) {
          
          self.politicalCarrerView?.startLoadingTg()
        politicalCarrerSerVice.callAPIPoliticalCarrer(
              user_id:user_id,  onSuccess: { (resp) in
                  self.politicalCarrerView?.finishLoadingTg()
                  if (resp.count == 0){
                  } else {
                      let mappedUsers = resp.map {
                          return PoliticalCarrerData(political_career_text_ta: "\($0.political_career_text_ta ?? "")", political_career_text_en: "\($0.political_career_text_en ?? "")")
                      }
                    self.politicalCarrerView?.setPoliticalValue(poliResp: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.politicalCarrerView?.finishLoadingTg()
                  self.politicalCarrerView?.setEmptyPc(errorMessage: errorMessage)

              }
          )
      }

}
