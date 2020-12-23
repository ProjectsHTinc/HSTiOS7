//
//  presenterUpdateService.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

struct ProfileUpdateData {
    let status: String
    let msg: String
}

protocol ProfileUpdatesView: NSObjectProtocol {
    func startLoadingUpdate()
    func finishLoadingUpdate()
    func setProfileUpdate(msg:String,status:String)
    func setEmptyUpdate(errorMessage:String)
}

class ProfileUpdatePresenter: NSObject {
    
    private let profileUpdateService:ProfileUpdateService
    weak private var profileUpdatesView : ProfileUpdatesView?

    init(profileUpdateService:ProfileUpdateService) {
        self.profileUpdateService = profileUpdateService
    }

    func attachView(view:ProfileUpdatesView) {
         profileUpdatesView = view
    }

    func detachViewClientUrl() {
        profileUpdatesView = nil
    }
    
    func getProfileUpdate(user_id:String,name:String,dob:String,phone:String,email:String,gender:String) {
        self.profileUpdatesView?.startLoadingUpdate()
        profileUpdateService.callAPIUserProfileUpdate(
            user_id: user_id, name: name,dob: dob, phone: phone, email: email, gender: gender, onSuccess: { (profUpdate) in
                self.profileUpdatesView?.finishLoadingUpdate()
                self.profileUpdatesView?.setProfileUpdate(msg:profUpdate.msg!,status: profUpdate.status!)
            },
            onFailure: { (errorMessage) in
                self.profileUpdatesView?.setEmptyUpdate(errorMessage: errorMessage)
                self.profileUpdatesView?.finishLoadingUpdate()

            }
        )
    }

}
