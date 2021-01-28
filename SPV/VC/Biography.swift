//
//  Biography.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class Biography: UIViewController {

    @IBOutlet weak var spvImage: UIImageView!
    @IBOutlet weak var personallife: UIView!
    @IBOutlet weak var politicalCareer: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.setUPsegmentControl ()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            personallife.alpha    = 1
            politicalCareer.alpha = 0
          
        } else {
            personallife.alpha    = 0
            politicalCareer.alpha = 1
        }
    }
    
    func setUPsegmentControl () {
        
        personallife.alpha    = 1
        politicalCareer.alpha = 0
        segmentControl.setTitle("Personal Life", forSegmentAt: 0)
        segmentControl.setTitle("Political Career", forSegmentAt: 1)
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
