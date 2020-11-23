//
//  GlobalVariables.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 17/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject {
    
    static let shared: GlobalVariables = GlobalVariables()
    var user_id = String()
    var localNewsId = String()
    var stateNewsId = String()
    var localEventsId = String()
    var stateEventsId = String()
    var socialInitiativesId = String()
    var nallarammTrustId = String()

}
