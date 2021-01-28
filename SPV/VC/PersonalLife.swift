//
//  PersonalLife.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class PersonalLife: UIViewController,PersonalLifeView {
    

    @IBOutlet weak var textView: UITextView!
    
    let presenter = PersonalLifePresenter(personalLifeSerVice: PersonalLifeSerVice())
    var resp = [PersonalLifeData]()
    
  var personalLife_tm = String ()
  var personalLife_en = String ()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callApi (user_id: "1")
    }
    
    func callApi (user_id: String)
        {
            presenter.attachView(view: self)
            presenter.getPersonalValues(user_id:user_id)
        }
        
    func startLoadingTg() {
//
    }
    
    func finishLoadingTg() {
//
    }
    
    func setPersonalLifeValue(poliResp: [PersonalLifeData]) {
        resp = poliResp
//
        for datas in resp {
            let titleTamil = datas.personal_life_text_ta
            let titleEnglish = datas.personal_life_text_en

            self.personalLife_tm.append(titleTamil!)
            self.personalLife_en.append(titleEnglish!)
            
            self.textView.text = personalLife_en
          }
    }
    
    func setEmptyPc(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
