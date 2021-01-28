//
//  PersonalLifePresenter.swift
//  SPV
//
//  Created by Happy Sanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


struct PersonalLifeData {
    
    let personal_life_text_en : String?
    let personal_life_text_ta: String?
    
}

protocol PersonalLifeView : NSObjectProtocol {
    func startLoadingTg()
    func finishLoadingTg()
    func setPersonalLifeValue(poliResp: [PersonalLifeData])
    func setEmptyPc(errorMessage:String)
}

class PersonalLifePresenter: NSObject {
    
    private let personalLifeSerVice: PersonalLifeSerVice
    weak private var personalLifeView : PersonalLifeView?
    
    init(personalLifeSerVice:PersonalLifeSerVice) {
        self.personalLifeSerVice = personalLifeSerVice
    }
    
    func attachView(view:PersonalLifeView) {
        personalLifeView = view
    }
    
    func detachView() {
        personalLifeView = nil
    }
    
    func getPersonalValues(user_id:String) {
          
          self.personalLifeView?.startLoadingTg()
        personalLifeSerVice.callAPIPersonalLife(
              user_id:user_id,  onSuccess: { (resp) in
                  self.personalLifeView?.finishLoadingTg()
                  if (resp.count == 0){
                  } else {
                      let mappedUsers = resp.map {
                        return PersonalLifeData(personal_life_text_en: "\($0.personal_life_text_en ?? "")", personal_life_text_ta: "\($0.personal_life_text_ta ?? "")")
                      }
                    self.personalLifeView?.setPersonalLifeValue(poliResp: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.personalLifeView?.finishLoadingTg()
                  self.personalLifeView?.setEmptyPc(errorMessage: errorMessage)

              }
          )
      }

}
