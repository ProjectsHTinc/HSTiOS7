//
//  profilePresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

struct ProfileDetailsData {
//    let user_id: String?
    let full_name : String?
    let phone_number : Int?
    let email_id : String?
//    let gender : String?
    let dob : String?
    let profile_pic : String?
}

protocol ProfileDetailsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setProfileDetails(full_name:String,phone_number:Int,email_id:String,dob:String,profile_pic:String)
    func setEmpty(errorMessage:String)
}

class ProfileDetailPresenter: NSObject {
    
    private let profileDetailService: ProfileDetailService
    weak private var profileDetailsView : ProfileDetailsView?

    init(profileDetailService:ProfileDetailService) {
        self.profileDetailService = profileDetailService
    }
    
    func attachView(view:ProfileDetailsView) {
        profileDetailsView = view
    }
    
    func detachView() {
        profileDetailsView = nil
    }
    
    func getProfileDetails(user_id:String) {
          self.profileDetailsView?.startLoading()
          profileDetailService.callAPIUserProfileDetails(
            user_id: user_id, onSuccess: { (profiledetails) in
            self.profileDetailsView?.finishLoading()
                self.profileDetailsView?.setProfileDetails(full_name: profiledetails.full_name!, phone_number: profiledetails.phone_number!, email_id: profiledetails.email_id!,dob:profiledetails.dob!, profile_pic: profiledetails.profile_pic!)
              },
              onFailure: { (errorMessage) in
                  self.profileDetailsView?.finishLoading()
                  self.profileDetailsView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
