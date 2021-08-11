//
//  NotableWorks.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class NotableWorks: UIViewController,NotableWorksView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = NotableWorksPresenter(notableWorksServices: NotableWorksServices())
    var resp = [NotableWorksData]()
         
    var Notable_TAM    = [String]()
    var Notable_ENG  = [String]()
    var NotableTitle_TAM    = [String]()
    var NotableTitle_ENG  = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI (user_id: "1")
    }
    
    func callAPI (user_id: String) {
               
        presenter.attachView(view: self)
        presenter.getnotableWorksValues(user_id: user_id)

    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
       
    func finishLoading() {
        self.view.activityStopAnimating()
    }
       
    func setNotableWorksValue(notableWorkspResp: [NotableWorksData]) {
        resp = notableWorkspResp
                       
                       for datas in resp {
                        
                           let titleTamil = datas.title_ta
                           let titleEnglish = datas.title_en
                           let NotableTextTamil = datas.noteable_text_ta
                           let NotableTextEnglish = datas.noteable_text_en
                        
                           self.Notable_TAM.append(NotableTextTamil!)
                           self.Notable_ENG.append(NotableTextEnglish!)
                           self.NotableTitle_TAM.append(titleTamil!)
                           self.NotableTitle_ENG.append(titleEnglish!)
                           
       }
        
        self.tableView.reloadData()
    }
       
    func setEmpty(errorMessage: String) {
           AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
            })
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notable_ENG.count
        
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (withIdentifier: "cell", for: indexPath) as! NotableWorksCell

        cell.title.text = NotableTitle_ENG[ indexPath.row]
        cell.textLbl.text = Notable_ENG[ indexPath.row]
               
               return cell
       }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}
