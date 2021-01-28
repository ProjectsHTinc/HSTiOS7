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
         case newsfeedCategoeryUrl = "apiuser/newsfeeds_category/"
         case newsfeedCategoeryId = "apiuser/newsfeeds_categoryid/"
         case allHomeUrl = "apiuser/all_newsfeeds/"
         case allNewsUrl = "apiuser/all_news//"
         case allEventsUrl = "apiuser/all_events/"
         case socilaMediaUrl = "apiuser/spv_socialmedia/"
         case homePageUrl = "apiuser/newsfeed_details/"
         case profileUpdateUrl  = "apiuser/profile_update/"
         case profilePicUrl     = "apiuser/profilepic_update/1/"
         case profileDetailsUrl = "apiuser/profile_details/"
         case electionDetails   = "apiuser/party_elections/"
         case positionHeld      = "apiuser/spv_positionheld/"
         case awards            = "apiuser/spv_awards/"
         case notableWorks      = "apiuser/spv_notable/"
         case political         = "apiuser/spv_political/"
         case personalLife       = "apiuser/spv_personal/"
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
        let url = MAIN_URL + Endpoint.otpUrl.rawValue
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
    func callAPIOTP(mobile_no:String, otp:String, onSuccess successCallback: ((_ otp: OTPModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
           // Build URL
           let url = MAIN_URL + Endpoint.loginUrl.rawValue
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
                              
            let full_name =  responseObject["userData"]["full_name"].string
            let language_id =  responseObject["userData"]["language_id"].string
            let phone_number =  responseObject["userData"]["phone_number"].string
            let profile_pic =  responseObject["userData"]["profile_pic"].string
            let user_id =  responseObject["userData"]["user_id"].string

            let sendToModel = OTPModel()
            sendToModel.full_name = full_name
            sendToModel.language_id = language_id
            sendToModel.phone_number = phone_number
            sendToModel.profile_pic = profile_pic
            sendToModel.user_id = user_id

            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func homeAPI (from:String, search_text:String, categoery:String, nf_category_id:String, offset:String, rowcount:String, onSuccess successCallback: ((_ resp: [HomeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        var url = String()
        var parameters: Parameters?
        if search_text == "yes"
        {
            url = MAIN_URL + Endpoint.otpUrl.rawValue
            // Set Parameters
            parameters =  ["offset":offset, "rowcount":rowcount]
        }
        else
        {
            if from == "home"
            {
                url = MAIN_URL + Endpoint.allHomeUrl.rawValue
                // Set Parameters
                parameters =  ["offset":offset, "rowcount":rowcount]
            }
            else if from == "news"
            {
                if categoery == "all"
                {
                    url = MAIN_URL + Endpoint.allNewsUrl.rawValue
                    // Set Parameters
                    parameters =  ["offset":offset, "rowcount":rowcount]
                }
                else if categoery == "Local News"
                {
                    url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                    // Set Parameters
                    parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]
                }
                else
                {
                    url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                    // Set Parameters
                    parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]
                }
            }
            else if from == "events"
            {
                if categoery == "all"
                {
                    url = MAIN_URL + Endpoint.allEventsUrl.rawValue
                    // Set Parameters
                    parameters =  ["offset":offset, "rowcount":rowcount]
                }
                else if categoery == "Local Events"
                {
                    url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                    // Set Parameters
                    parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]
                }
                else
                {
                    url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                    // Set Parameters
                    parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]
                }
            }
            else if from == "Socialinitiatives"
            {
                    url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                    // Set Parameters
                    parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]

            }
            else if from == "nallarammTrust"
            {
                url = MAIN_URL + Endpoint.newsfeedCategoeryId.rawValue
                // Set Parameters
                parameters =  ["nf_category_id":nf_category_id, "offset":offset, "rowcount":rowcount]

            }
        }
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
        if let responseDict = responseObject["nf_result"].arrayObject
        {
                let toModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [HomeModel]()
                for item in toModel {
                    let single = HomeModel.build(item)
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
    
    func callNewsFeed(user_id:String,onSuccess successCallback: ((_ newsFeed: [NewsFeedModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.loginUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "OTP Generated" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
          if let responseDict = responseObject["userData"].arrayObject
             {
                 let newsFeedModel = responseDict as! [[String:AnyObject]]
                 // Create object
                 var data = [NewsFeedModel]()
                 for item in newsFeedModel {
                     let single = NewsFeedModel.build(item)
                     data.append(single)
                 }
                    // Fire callback
                 successCallback?(data)
               }else {
                    failureCallback?("An error has occured.")
                }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func callSocilaMedia(user_id:String,onSuccess successCallback: ((_ socialMedia: [SocilaMediaModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.socilaMediaUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
          if let responseDict = responseObject["socialmedia_result"].arrayObject
             {
                 let socilaMediaModel = responseDict as! [[String:AnyObject]]
                 // Create object
                 var data = [SocilaMediaModel]()
                 for item in socilaMediaModel {
                     let single = SocilaMediaModel.build(item)
                     data.append(single)
                 }
                    // Fire callback
                 successCallback?(data)
               }else {
                    failureCallback?("An error has occured.")
                }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func homePageDetail (user_id:String, newsfeed_id:String, onSuccess successCallback: ((_ resp: [HomePageDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.homePageUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["newsfeed_id":newsfeed_id]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
        if let responseDict = responseObject["image_result"].arrayObject
        {
                let toModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [HomePageDetailModel]()
                for item in toModel {
                    let single = HomePageDetailModel.build(item)
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
    
    func callAPIUserProfileDetails(user_id:String, onSuccess successCallback: ((_ userProfileModel: UserProfileModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url =  MAIN_URL + Endpoint.profileDetailsUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

          let respphone_number = responseObject["user_details"]["phone_number"].int
          let resPro_pic = responseObject["user_details"]["profile_pic"].string
          let respemail_id = responseObject["user_details"]["email_id"].string
          let respfull_name = responseObject["user_details"]["full_name"].string
          let respdob = responseObject["user_details"]["dob"].string
//          let respgender = responseObject["user_details"]["gender"].string
//          let respuser_id = responseObject["user_details"]["id"].string

          // Create object
          let sendToModel = UserProfileModel()
          sendToModel.phone_number = respphone_number
          sendToModel.profile_pic = resPro_pic
          sendToModel.email_id = respemail_id
          sendToModel.full_name = respfull_name
          sendToModel.dob = respdob
//          sendToModel.gender = respgender
//         sendToModel.user_id = respuser_id
          successCallback?(sendToModel)
          
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    func callAPIUserProfileUpdate(user_id:String,name:String,dob:String,phone:String,email:String,gender:String, onSuccess successCallback: ((_ userProfileUpdateModel: UserProfileUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.profileUpdateUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"full_name": name,"dob": dob,"phone_number": phone,"email_id": email,"gender": gender]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

         let respMsg = responseObject["msg"].string
         let respStatus = responseObject["status"].string


         // Create object
         let sendToModel = UserProfileUpdateModel()
         sendToModel.msg = respMsg
         sendToModel.status = respStatus
        
        successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    //MARK: GET USER PROFILE PIC UPDATE RESPONSE
    func callAPIUserProfilePicUpdate(user_id:String, onSuccess successCallback: ((_ userProfilePicModel: UserProfilePicModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.profilePicUrl.rawValue + user_id
        // Set Parameters
        let parameters: Parameters =  ["user_pic": ""]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)

          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    func electionAPI(user_id:String, onSuccess successCallback: ((_ resp: [ElectionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
         // Build URL
         let url = MAIN_URL + Endpoint.electionDetails.rawValue
         // Set Parameters
         let parameters: Parameters =  ["user_id": user_id]
         // call API
         self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
         // Create dictionary
         print(responseObject)

           guard let status = responseObject["status"].string, status == "Success" else{
               failureCallback?(responseObject["msg"
               ].string!)
               return
         }
          if let responseDict = responseObject["election_result"].arrayObject
          {
                  let toModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ElectionModel]()
                  for item in toModel {
                      let single = ElectionModel.build(item)
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
    func positionHeldAPI(user_id:String, onSuccess successCallback: ((_ resp: [PositionHeldModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
           // Build URL
           let url = MAIN_URL + Endpoint.positionHeld.rawValue
           // Set Parameters
           let parameters: Parameters =  ["user_id": user_id]
           // call API
           self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
           // Create dictionary
           print(responseObject)

             guard let status = responseObject["msg"].string, status == "Position Details" else{
                 failureCallback?(responseObject["status"
                 ].string!)
                 return
           }
            if let responseDict = responseObject["position_result"].arrayObject
            {
                    let toModel = responseDict as! [[String:AnyObject]]
                    // Create object
                    var data = [PositionHeldModel]()
                    for item in toModel {
                        let single = PositionHeldModel.build(item)
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
    
    func awardsAPI(user_id:String, onSuccess successCallback: ((_ resp: [AwardsModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
             // Build URL
             let url = MAIN_URL + Endpoint.awards.rawValue
             // Set Parameters
             let parameters: Parameters =  ["user_id": user_id]
             // call API
             self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
             // Create dictionary
             print(responseObject)

               guard let status = responseObject["status"].string, status == "Success" else{
                   failureCallback?(responseObject["msg"
                   ].string!)
                   return
             }
//                award_page_heading
//                let resPageTitleEn = responseObject["award_page_heading"]["page_title_en"].string
//                let resPageTitleTa = responseObject["award_page_heading"]["page_title_ta"].string

                if let responseDict = responseObject["award_result"].arrayObject
               {
                      let toModel = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [AwardsModel]()
                      for item in toModel {
                          let single = AwardsModel.build(item)
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
    
    func notableWorksAPI(user_id:String, onSuccess successCallback: ((_ resp: [NotableWorksModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
                 // Build URL
                 let url = MAIN_URL + Endpoint.notableWorks.rawValue
                 // Set Parameters
                 let parameters: Parameters =  ["user_id": user_id]
                 // call API
                 self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
                 // Create dictionary
                 print(responseObject)

                   guard let status = responseObject["status"].string, status == "Success" else{
                       failureCallback?(responseObject["msg"
                       ].string!)
                       return
                 }

                  if let responseDict = responseObject["position_result"].arrayObject
                  {
                          let toModel = responseDict as! [[String:AnyObject]]
                          // Create object
                          var data = [NotableWorksModel]()
                          for item in toModel {
                              let single = NotableWorksModel.build(item)
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
    // Create object
  
    func callAPIPoliticalCarrer(user_id:String, onSuccess successCallback: ((_ resp: [PoliticalCarrerModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
                 // Build URL
                 let url = MAIN_URL + Endpoint.political.rawValue
                 // Set Parameters
                 let parameters: Parameters =  ["user_id": user_id]
                 // call API
                 self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
                 // Create dictionary
                 print(responseObject)

                   guard let status = responseObject["status"].string, status == "Success" else{
                       failureCallback?(responseObject["msg"
                       ].string!)
                       return
                 }
   
                  if let responseDict = responseObject["political_result"].arrayObject
                  {
                          let toModel = responseDict as! [[String:AnyObject]]
                          // Create object
                          var data = [PoliticalCarrerModel]()
                          for item in toModel {
                              let single = PoliticalCarrerModel.build(item)
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
    
    func callAPIPersonalLife(user_id:String, onSuccess successCallback: ((_ resp: [PersonalLifeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
                 // Build URL
                 let url = MAIN_URL + Endpoint.personalLife.rawValue
                 // Set Parameters
                 let parameters: Parameters =  ["user_id": user_id]
                 // call API
                 self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
                 // Create dictionary
                 print(responseObject)

                   guard let status = responseObject["status"].string, status == "Success" else{
                       failureCallback?(responseObject["msg"
                       ].string!)
                       return
                 }
   
                  if let responseDict = responseObject["personal_result"].arrayObject
                  {
                          let toModel = responseDict as! [[String:AnyObject]]
                          // Create object
                          var data = [PersonalLifeModel]()
                          for item in toModel {
                              let single = PersonalLifeModel.build(item)
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
