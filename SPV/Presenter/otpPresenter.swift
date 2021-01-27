//
//  otpPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 11/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//


import UIKit

//struct OtpData:Codable {
//    //let user_count : Int
//    let full_name : String
//    let user_id : String
//    let profile_pic : String
//    let language_id : String
//    let phone_number : String
//
//}
//
//protocol OtpView: NSObjectProtocol {
//
//    func startLoadingOtp()
//    func finishLoadingOtp()
//    func setOtp(otpValue: [OtpData])
//    func setEmptyOtp(errorMessage:String)
//}
//
//class OTPPresenter {
//
//      private let oTPService: OTPService
//      weak private var otpView : OtpView?
//
//      init(oTPService:OTPService) {
//          self.oTPService = oTPService
//      }
//
//      func attachView(view:OtpView) {
//          otpView = view
//      }
//
//      func detachView() {
//          otpView = nil
//      }
//
//      func getOtpForOtpPage(mobile_no:String, otp:String) {
//          self.otpView?.startLoadingOtp()
//          oTPService.callAPIOTP(
//            mobile_no: mobile_no, otp: otp, onSuccess: { (otp) in
//                  self.otpView?.finishLoadingOtp()
//                  if (otp.count == 0){
//                  } else {
//                    let mappedUsers = otp.map {
//                        return OtpData(full_name: "\($0.full_name ?? "")", user_id: "\($0.user_id ?? "")", profile_pic: "\($0.profile_pic ?? "")", language_id: "\($0.language_id ?? "")", phone_number:"\($0.profile_pic ?? "")")
//                       }
//                    self.otpView?.setOtp(otpValue: mappedUsers)
//                    UserDefaults.standard.setOtpArray(mappedUsers, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
//                  }
//              },
//              onFailure: { (errorMessage) in
//                  self.otpView?.finishLoadingOtp()
//                  self.otpView?.setEmptyOtp(errorMessage: errorMessage)
//
//              }
//          )
//      }
//}

struct OtpData {
    let full_name : String
    let user_id : String
    let profile_pic : String
    let language_id : String
    let phone_number : String
}

protocol OtpView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setLoginOtp(full_name:String,user_id:String,profile_pic:String,language_id:String,phone_number:String)
    func setEmptyLogin(errorMessage:String)
}

class OTPPresenter {
    
    private let oTPService:OTPService
    weak private var otpView : OtpView?
    
    init(oTPService:OTPService) {
        self.oTPService = oTPService
    }
    
    func attachView(view:OtpView) {
        otpView = view
    }
    
    func detachViewClientUrl() {
        otpView = nil
    }
    
    func getOtpForOtpPage(mobile_no:String, otp:String) {
        self.otpView?.startLoading()
        oTPService.callAPIOTP(
            mobile_no: mobile_no, otp: otp, onSuccess: { (otp) in
                self.otpView?.setLoginOtp(full_name: otp.full_name!,user_id: otp.user_id!,profile_pic: otp.profile_pic!,language_id: otp.language_id!,phone_number: otp.phone_number!)
                self.otpView?.finishLoading()
        },
            onFailure: { (errorMessage) in
                self.otpView?.setEmptyLogin(errorMessage: errorMessage)
                self.otpView?.finishLoading()
        }
        )
    }
}
