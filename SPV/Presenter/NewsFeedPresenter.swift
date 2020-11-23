//
//  NewsFeedPresenter.swift
//  SPV
//
//  Created by Happy Sanz Tech on 09/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

struct newsFeedData:Codable {
    let id : String
    let category_name : String
    let status : String
}

protocol NewsFeedView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setNewsFeed(newsfeedValue: [newsFeedData])
    func setEmpty(errorMessage:String)
}

class NewsFeedPresenter: NSObject {

    private let newsFeedServices: NewsFeedServices
    weak private var newsFeedView : NewsFeedView?
    
    init(newsFeedServices:NewsFeedServices) {
        self.newsFeedServices = newsFeedServices
    }
    
    func attachView(view:NewsFeedView) {
        newsFeedView = view
    }
    
    func detachView() {
        newsFeedView = nil
    }
  
    func getNewsFeed(user_id:String) {
        self.newsFeedView?.startLoading()
        newsFeedServices.callNewsFeed(
            user_id: user_id, onSuccess: { (newsFeed) in
                self.newsFeedView?.finishLoading()
                if (newsFeed.count == 0){
                } else {
                  let mappedUsers = newsFeed.map {
                      return newsFeedData(id: "\($0.id ?? "")", category_name: "\($0.category_name ?? "")", status: "\($0.status ?? "")")
                     }
                  self.newsFeedView?.setNewsFeed(newsfeedValue: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.newsFeedView?.finishLoading()
                self.newsFeedView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
