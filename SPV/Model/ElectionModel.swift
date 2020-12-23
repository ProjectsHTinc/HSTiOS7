//
//  ElectionModel.swift
//  SPV
//
//  Created by HappySanz Tech on 23/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class ElectionModel {

    var seats_won : String?
    var party_leader_ta : String?
    var party_leader_en : String?
    var election_year : String?
    
     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
         if let data = dict["seats_won"] as? String {
             self.seats_won = data
         }
         if let data = dict["party_leader_ta"] as? String {
             self.party_leader_ta = data
         }
         if let data = dict["party_leader_en"] as? String {
             self.party_leader_en = data
         }
         if let data = dict["election_year"] as? String {
            self.election_year = data
        }
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> ElectionModel {
         let model = ElectionModel()
         model.loadFromDictionary(dict)
         return model
     }

}
