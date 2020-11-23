//
//  SocialMediaPresenter.swift
//  SPV
//
//  Created by Happy Sanz Tech on 12/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

struct SocilaMediaData {
    let id : String
    let sm_title : String
    let sm_url : String
    let status : String
    let created_by : String
    let created_at : String
    let updated_by : String
    let updated_at : String
}

protocol SocialMediaView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setSocialMedia(socilaMedia: [SocilaMediaData])
    func setEmpty(errorMessage:String)
}

class SocialMediaPresenter: NSObject {
    
    private let socialMediaService: SocialMediaService
    weak private var socialMediaView : SocialMediaView?
    
    init(socialMediaService:SocialMediaService) {
        self.socialMediaService = socialMediaService
    }
    
    func attachView(view:SocialMediaView) {
        socialMediaView = view
    }
    
    func detachView() {
        socialMediaView = nil
    }
  
    func getSocilaMedia(user_id:String) {
        self.socialMediaView?.startLoading()
        socialMediaService.callSocilaMedia(
            user_id: user_id, onSuccess: { (socilaMedia) in
                self.socialMediaView?.finishLoading()
                if (socilaMedia.count == 0){
                } else {
                  let mappedUsers = socilaMedia.map {
                    return SocilaMediaData(id: "\($0.id ?? "")", sm_title: "\($0.sm_title ?? "")", sm_url: "\($0.sm_url ?? "")", status: "\($0.status ?? "")", created_by: "\($0.created_by ?? "")", created_at: "\($0.created_at ?? "")", updated_by: "\($0.updated_by ?? "")", updated_at: "\($0.updated_at ?? "")")
                     }
                  self.socialMediaView?.setSocialMedia(socilaMedia: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.socialMediaView?.finishLoading()
                self.socialMediaView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }

}
