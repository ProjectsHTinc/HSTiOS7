//
//  YourSpv.swift
//  SPV
//
//  Created by HappySanz Tech on 25/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit
import HMSegmentedControl

class YourSpv: UIViewController {
      
    
    @IBOutlet weak var segView: UIView!
    @IBOutlet weak var biography: UIView!
    @IBOutlet weak var positionHeld: UIView!
    @IBOutlet weak var awards: UIView!
    @IBOutlet weak var notableWorks: UIView!
    
    var spvTitles = [String]()
    var segmentedControl = HMSegmentedControl()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        spvTitles = ["BIOGRAPHY","POSITION HELD","AWARDS","NOTABLE WORKS"]
        self.setUpSegementControl ()
        
    }
    
    func setUpSegementControl () {
        
        biography.alpha  = 1
        positionHeld.alpha   = 0
        awards.alpha = 0
        notableWorks.alpha = 0
        segmentedControl = HMSegmentedControl(sectionTitles: self.spvTitles)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 17.0/255.0, green: 89.0/255.0, blue: 168.0/255.0, alpha: 1.0)]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.selectionIndicatorColor = UIColor(red: 17.0/255.0, green: 89.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 16.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
           
        if segmentedControl.selectedSegmentIndex == 0
        {
               biography.alpha  = 1
               positionHeld.alpha   = 0
               awards.alpha = 0
               notableWorks.alpha = 0
           }
        else if segmentedControl.selectedSegmentIndex == 1
           {
            biography.alpha  = 0
            positionHeld.alpha   = 1
            awards.alpha = 0
            notableWorks.alpha = 0
        }
        else if segmentedControl.selectedSegmentIndex == 2
           {
            biography.alpha  = 0
            positionHeld.alpha   = 0
            awards.alpha = 1
            notableWorks.alpha = 0
        }
        else
        {
            biography.alpha  = 0
            positionHeld.alpha   = 0
            awards.alpha = 0
            notableWorks.alpha = 1
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

}
