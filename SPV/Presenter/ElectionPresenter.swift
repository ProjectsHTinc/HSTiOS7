//
//  ElectionPresenter.swift
//  SPV
//
//  Created by HappySanz Tech on 23/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

struct ElectionData {
    
     let seats_won : String?
     let party_leader_ta : String?
     let party_leader_en : String?
     let election_year : String?
}
protocol ElectionView : NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setElectionValues(elecResp: [ElectionData])
    func setEmpty(errorMessage:String)
}

class ELectionPresenter {
    
    private let electionServices: ElectionServices
    weak private var electionView : ElectionView?
    
    init(electionServices:ElectionServices) {
        self.electionServices = electionServices
    }
    
    func attachView(view:ElectionView) {
        electionView = view
    }
    
    func detachView() {
        electionView = nil
    }

  func getElectionValues(user_id:String) {
        
        self.electionView?.startLoading()
        electionServices.electionAPI(
            user_id:user_id,  onSuccess: { (resp) in
                self.electionView?.finishLoading()
                if (resp.count == 0){
                } else {
                    let mappedUsers = resp.map {
                        return ElectionData(seats_won: "\($0.seats_won ?? "")", party_leader_ta: "\($0.party_leader_ta ?? "")", party_leader_en: "\($0.party_leader_en ?? "")", election_year: "\($0.election_year ?? "")")
                    }
                    self.electionView?.setElectionValues(elecResp: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.electionView?.finishLoading()
                self.electionView?.setEmpty(errorMessage: errorMessage)

            }
        )
    }
}
