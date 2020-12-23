//
//  ideology.swift
//  SPV
//
//  Created by HappySanz Tech on 03/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class ideology: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.textView.text = "The AIADMK sought to depoliticize the education policy of the government by not insisting that education be the Tamil language. Policies of AIADMK were targeted to the poorer segments of Tamil society – poor, rickshaw pullers, and destitute women and centralizing the massive noon meal scheme for children.There was ambivalence toward the reservation policy and interests of farmers. The AIADMK and its prime opposition party, the DMK posted an array of populist schemes targeting the human development index of the state. Both the parties have schemes listed in the election manifestos covering segments of the population including fishermen, farmers, and school children. Till the 2000s, the parties had welfare schemes like maternity assistance, subsidized public transport, and educational grants. After the 2000s, the parties started competing at an increasing level for the distribution of consumer goods. The AIADMK government distributed free cycles to class 11 and class 12 students during its tenure of 2001–06. The DMK, in competition, promised free color televisions in its manifesto in 2006 assembly elections. The competition continued during the 2011 assembly elections when both parties announced free laptops for schools students and grinders mixers and fans for public."
    
    self.hideKeyboardWhenTappedAround()
     
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
