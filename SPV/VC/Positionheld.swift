//
//  Positionheld.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class Positionheld: UIViewController,PostionHeldView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = PositionHeldPresenter(positionheldServices: PositionHeldServices())
    var resp = [PositionHeldData]()
      
    var positionHeld_ta = [String]()
    var positionHeld_en = [String]()
    var Title_Ta        = [String]()
    var Title_En        = [String]()
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
           self.callAPI (user_id: "1")
        // Do any additional setup after loading the view.
       }
       
    func callAPI (user_id: String) {
            
            presenter.attachView(view: self)
            presenter.getPositionHeldValues(user_id: user_id)
    }
    
    func startLoading()
    {
         self.view.activityStartAnimating()
    }
    
    func finishLoading()
    {
         self.view.activityStopAnimating()
    }
    
    func setElectionHeldValue(positionResp: [PositionHeldData])
    {
        resp = positionResp
        
        for datas in resp {
            let titleTamil = datas.title_ta
            let titleEnglish = datas.title_en
            let positionTamil = datas.position_text_ta
            let positionEnglish = datas.position_text_en
            
            self.positionHeld_ta.append(positionTamil!)
            self.positionHeld_en.append(positionEnglish!)
            self.Title_Ta.append(titleTamil!)
            self.Title_En.append(titleEnglish!)
            print (Title_En)
          }
        
        self.tableView.reloadData ()
    }
    
    func setEmpty(errorMessage: String) {
       
        AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Title_En.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell (withIdentifier: "cell", for: indexPath) as! PositionHeldCell

        cell.title.text = Title_En[indexPath.row]
        cell.textView.text = positionHeld_en[indexPath.row]
        
        return cell
    }

}
        
    

