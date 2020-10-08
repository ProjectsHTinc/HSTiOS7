//
//  NavigationBarTitleOnLeftSide.swift
//  SPV
//
//  Created by HappySanz Tech on 07/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

extension UIViewController
{
    func navTitleOnLeftSide (){
        
        let longTitleLabel = UILabel()
            longTitleLabel.text = ""
            longTitleLabel.font = UIFont(name: "Poppins-Medium", size: 18)
            longTitleLabel.textColor = UIColor.white
            longTitleLabel.sizeToFit()

            let leftItem = UIBarButtonItem(customView: longTitleLabel)
            self.navigationItem.leftBarButtonItem = leftItem
    }
}
