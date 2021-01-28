//
//  PersonalLifeModel.swift
//  SPV
//
//  Created by Happy Sanz Tech on 26/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit


class PersonalLifeModel {
    
    var personal_life_text_en: String?
    var personal_life_text_ta: String?
    

    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        
        if let data = dict["personal_life_text_en"] as? String {
            self.personal_life_text_en = data
        }
        if let data = dict["personal_life_text_ta"] as? String {
            self.personal_life_text_ta = data
        }
    }
    
    // MARK: Class Method
    
    class func build(_ dict: [String: AnyObject]) -> PersonalLifeModel {
        let model = PersonalLifeModel()
        model.loadFromDictionary(dict)
        return model
    }

}
