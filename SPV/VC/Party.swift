//
//  Party.swift
//  SPV
//
//  Created by HappySanz Tech on 30/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class Party: UIViewController {

    @IBOutlet weak var segmentContorl: UISegmentedControl!
    @IBOutlet weak var ideology: UIView!
    @IBOutlet weak var history: UIView!
    @IBOutlet weak var elections: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpSegmentedControll()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
          if (sender as AnyObject).selectedSegmentIndex == 0 {
            ideology.alpha  = 1
            history.alpha   = 0
            elections.alpha = 0
        } else if (sender as AnyObject).selectedSegmentIndex == 1 {
            ideology.alpha  = 0
            history.alpha   = 1
            elections.alpha = 0
        } else {
            ideology.alpha  = 0
            history.alpha   = 0
            elections.alpha = 1
        }
    }
    
    func setUpSegmentedControll () {
        
        ideology.alpha  = 1
        history.alpha   = 0
        elections.alpha = 0
        segmentContorl.setTitle("Ideology", forSegmentAt: 0)
        segmentContorl.setTitle("History", forSegmentAt: 1)
        segmentContorl.setTitle("Elections", forSegmentAt: 2)
        segmentContorl.backgroundColor = UIColor(red: 234/255.0, green: 236/255.0, blue: 240/255.0, alpha: 1.0)
        segmentContorl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 14) as Any], for: .normal)
        segmentContorl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentContorl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentContorl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 14) as Any], for: .selected)
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
