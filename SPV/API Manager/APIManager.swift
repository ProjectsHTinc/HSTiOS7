//
//  APIManager.swift
//  
//
//  Created by HappySanz Tech on 07/10/20.
//

import UIKit
import Alamofire
import SwiftyJSON

let MAIN_URL = "https://happysanz.in/spveluapp/"

class APIManager: NSObject {
    
    
    static let instance = APIManager()
    var manager: SessionManager {
        let manager = Alamofire.SessionManager.default
      manager.session.configuration.timeoutIntervalForRequest = 3.0
        return manager
    }
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
         case loginUrl = "apiuser/login/"
         case otpUrl = "apiuser/generate_otp/"
    }
         
    // Create Request
    func createRequest (_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    func callAPILogin(mobile_no:String,onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.loginUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_number": mobile_no]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "OTP Generated" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            let mobile_otp =  responseObject["otp"].string
            let message =  responseObject["msg"].string
            let status =  responseObject["status"].string

            let sendToModel = LoginModel()
            sendToModel.mobile_otp = mobile_otp
            sendToModel.msg = message
            sendToModel.status = status

            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE LOGIN REQUEST
    func callAPIOTP(mobile_no:String, otp:String, onSuccess successCallback: ((_ otp: [OTPModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
           // Build URL
           let url = MAIN_URL + Endpoint.otpUrl.rawValue
           // Set Parameters
           let parameters: Parameters =  ["mobile_number": mobile_no, "otp": otp,  "device_token":"abcd" , "device_type": Globals.device_type]
           // call API
           self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
           // Create dictionary
           print(responseObject)
             
             guard let msg = responseObject["msg"].string, msg == "Login Successfully" else{
                 failureCallback?(responseObject["msg"].string!)
                 return
           }
               
//             GlobalVariables.shared.userCount = responseObject["user_count"].int!
               
             if let responseDict = responseObject["userData"].arrayObject
             {
                   let otpModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [OTPModel]()
                   for item in otpModel {
                       let single = OTPModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
               
           },
           onFailure: {(errorMessage: String) -> Void in
               failureCallback?(errorMessage)
           }
         )
    }
}
