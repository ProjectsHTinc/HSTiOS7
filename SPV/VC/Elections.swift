//
//  Elections.swift
//  
//
//  Created by HappySanz Tech on 03/11/20.
//

import UIKit

class Elections: UIViewController,ElectionView {
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = ELectionPresenter(electionServices: ElectionServices())
    var resp = [ElectionData]()
    
    var seat_won       = [String]()
    var party_lead_ta  = [String]()
    var party_lead_en  = [String]()
    var elect_year     = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI (user_id: "1")
        self.hideKeyboardWhenTappedAround()
//        print(seat_won)
//
    }
    
    func callAPI (user_id: String) {
        
        presenter.attachView(view: self)
        presenter.getElectionValues(user_id: user_id)
    }

}

extension Elections : UITableViewDelegate,UITableViewDataSource {
    
   
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setElectionValues(elecResp: [ElectionData]) {
        resp = elecResp
        
        for datas in resp {
            let year = datas.seats_won
            let leader_ta = datas.party_leader_ta
            let leader_en = datas.party_leader_en
            let seats = datas.election_year
            
            self.seat_won.append(seats!)
            self.party_lead_en.append(leader_en!)
            self.elect_year.append(year!)
            self.party_lead_ta.append(leader_ta!)
            print (elect_year)
            
          }
            self.tableView.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
        
        AlertController.shared.showAlert(targetVc: self, title: "S.P.V", message: errorMessage, complition: {
               })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return seat_won.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell (withIdentifier: "cell", for: indexPath) as! ElectionCell

        cell.electionYear.text = elect_year[indexPath.row]
        cell.partyLeader.text  = party_lead_en[indexPath.row]
        cell.seatsWon.text     = seat_won[indexPath.row]
          
        return cell
       }
       
}
