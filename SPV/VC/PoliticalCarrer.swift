//
//  PoliticalCarrer.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class PoliticalCarrer: UIViewController,PoliticalCarrerView {
    

    @IBOutlet weak var textView: UITextView!
    
      let presenter = PoliticalCarrerPresenter(politicalCarrerSerVice: PoliticalCarrerSerVice())
      var resp = [PoliticalCarrerData]()
      
    var political_tm = String ()
    var political_en = String ()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.callApi (user_id: "1")
    }
    
    func callApi (user_id: String)
    {
        presenter.attachView(view: self)
        presenter.getPoliticalValues(user_id:user_id)
    }
    
    func startLoadingTg() {
//
    }
    
    func finishLoadingTg() {
//
    }
    
    func setPoliticalValue(poliResp: [PoliticalCarrerData])
    {
        resp = poliResp
//
        for datas in resp {
            let titleTamil = datas.political_career_text_ta
            let titleEnglish = datas.political_career_text_en

            self.political_tm.append(titleTamil!)
            self.political_en.append(titleEnglish!)
            self.textView.text = political_en
          }
    }
        
    func setEmptyPc(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
        })
    }
   
}
