//
//  History.swift
//  SPV
//
//  Created by HappySanz Tech on 03/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class History: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.textView.text = "The party was founded in 1972 as Anna Dravida Munnetra Kazhagam (ADMK) by M. G. Ramachandran, a veteran Tamil film star and popular politician. It was set up as a breakaway faction of the Dravida Munnetra Kazhagam (DMK) led by M. Karunanidhi, then Chief Minister of Tamil Nadu, owing to differences between the two.Later, MGR prefixed the All India (AI) tag to the party's name. Since its inception, the relationship between the AIADMK and DMK has been marked by mutual contempt. MGR used his fan network to build the party cadre with claims his party recruited more than a million members in the first two months. C. N. Annadurai's ideologue and movie mogul R. M. Veerppan was the key architect in unifying the MGR fan clubs and further consolidating the party structure in the 70s. Other key leaders such as Nanjil K. Manoharan and S. D. Somasundaram played major roles in consolidation.The party's first victories were the Dindigul parliamentary by-election in 1973 and the Coimbatore assembly by-election a year later.On 2 April 1973, AIADMK emerged as the third largest political party in Tamil Nadu, represented by 11 MLAs in the assembly. By 31 January 1976, AIADMK emerged as the second largest political party in Tamil Nadu with 16 MLAs in the assembly. AIADMK grew close to the Congress Party by supporting the National Emergency between 1975 and 1977."
        
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
