//
//  PoliticalCarrerModel.swift
//  SPV
//
//  Created by HappySanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import Foundation

class PoliticalCarrerModel {
    
    var political_career_text_en: String?
    var political_career_text_ta: String?
    

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["political_career_text_en"] as? String {
            self.political_career_text_en = data
        }
        if let data = dict["political_career_text_ta"] as? String {
            self.political_career_text_ta = data
        }
    }
    
    // MARK: Class Method
    
    class func build(_ dict: [String: AnyObject]) -> PoliticalCarrerModel {
        let model = PoliticalCarrerModel()
        model.loadFromDictionary(dict)
        return model
    }

}
