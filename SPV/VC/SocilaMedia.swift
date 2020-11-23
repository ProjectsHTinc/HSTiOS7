//
//  SocilaMedia.swift
//  SPV
//
//  Created by Happy Sanz Tech on 12/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit
import WebKit

class SocilaMedia: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    var segmentedControl = HMSegmentedControl()
    var mediaName = [String]()
    var data = [String]()
    let presenter = SocialMediaPresenter(socialMediaService: SocialMediaService())
    var resp = [SocilaMediaData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        self.callAPI()
    }
    
    func callAPI()
    {
        presenter.attachView(view: self)
        presenter.getSocilaMedia(user_id: "1")
    }
    
    func setUpSegementControl ()
    {
        segmentedControl = HMSegmentedControl(sectionTitles: self.mediaName)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 86.0/255.0, green: 86.0/255.0, blue: 86.0/255.0, alpha: 1.0)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 17.0/255.0, green: 89.0/255.0, blue: 168.0/255.0, alpha: 1.0)]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.selectionIndicatorColor = UIColor(red: 17.0/255.0, green: 89.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 15.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        let url = data[Int(segmentedControl.selectedSegmentIndex)]
        print(url)
        let request = URLRequest(url: URL(string: url)!)
        webView?.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         print("Start to load")
         //self.view.activityStartAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("finish to load")
         //self.view.activityStopAnimating()

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
extension SocilaMedia : SocialMediaView
{
    func startLoading() {
        //self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        //self.view.activityStartAnimating()
    }
    
    func setSocialMedia(socilaMedia: [SocilaMediaData]) {
        resp = socilaMedia
        for items in resp {
            mediaName.append(items.sm_title)
            data.append(items.sm_url)
        }
        let request = URLRequest(url: URL(string: data[0])!)
        webView?.load(request)
        setUpSegementControl()
        
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    
}
