//
//  Awards.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class Awards: UIViewController,AwardsView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = AwardsPresenter(awardsServices: AwardsServices())
    var resp = [AwardsData]()
      
    var awardText_Tamil    = [String]()
    var awardText_English  = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

//         self.callAPI (user_id: "1")
        
        // Do any additional setup after loading the view.
    }
    
    func callAPI (user_id: String) {
            
            presenter.attachView(view: self)
            presenter.getAwardsValues(user_id: user_id)

        // Do any additional setup after loading the view.
    }
    
    func startLoading() {
           self.view.activityStartAnimating()
    }
    
    func finishLoading() {
           self.view.activityStopAnimating()
    }
    
    func setAwardsValue(awardsRespResp: [AwardsData]) {
        resp = awardsRespResp
            
            for datas in resp {
//                let titleTamil = datas.title_ta
//                let titleEnglish = datas.title_en
                let awardText_TA = datas.awards_text_ta
                let awardText_EN = datas.awards_text_en
                
                self.awardText_Tamil.append(awardText_TA!)
                self.awardText_English.append(awardText_EN!)
//               self.Title_Ta.append(titleTamil!)
//                self.Title_En.append(titleEnglish!)
//
                print(awardText_Tamil)
              }
            self.tableView.reloadData ()
        
    }
    
    func setEmpty(errorMessage: String) {
        
        AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
               })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return awardText_English.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell (withIdentifier: "cell", for: indexPath) as! AwardsCell

           cell.textlbl.text = awardText_English[ indexPath.row]
                  
                  return cell
       }
       
}
       
      
       

    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


