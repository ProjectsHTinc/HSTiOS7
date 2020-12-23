//
//  ProfilePicUploadPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 10/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation
import UIKit

struct ProfilePicData {
    let status: String
    let msg: String
}

protocol ProfilePicView: NSObjectProtocol {
    func startLoadingPic()
    func finishLoadingPic()
    func setProfilePic(msg:String,status:String)
    func setEmptyPic(errorMessage:String)
}

class ProfilePicPresenter: NSObject {
    
     private let profilePicUploadService:ProfilePicUploadService
     weak private var profilePicView : ProfilePicView?

     init(profilePicUploadService:ProfilePicUploadService) {
         self.profilePicUploadService = profilePicUploadService
     }

     func attachView(view:ProfilePicView) {
          profilePicView = view
     }

     func detachViewClientUrl() {
         profilePicView = nil
     }
     
     func getProfilePic(user_id:String) {
         self.profilePicView?.startLoadingPic()
         profilePicUploadService.callAPIUserProfilePicUpdate(
            user_id: user_id, onSuccess: { (profUpdate) in
                 self.profilePicView?.finishLoadingPic()
                 self.profilePicView?.setProfilePic(msg:profUpdate.msg!,status: profUpdate.status!)
             },
             onFailure: { (errorMessage) in
                 self.profilePicView?.setEmptyPic(errorMessage: errorMessage)
                 self.profilePicView?.finishLoadingPic()
             }
         )
     }

}
