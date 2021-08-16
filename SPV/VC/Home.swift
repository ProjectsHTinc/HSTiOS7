//
//  Home.swift
//  SPV
//
//  Created by Happy Sanz Tech on 23/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit
import SDWebImage

class Home: UIViewController, NewsFeedView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chatView: RoundedView!
    
    var lastContentOffset: CGFloat = 0
    var spvData = [String]()
    let presenter = HomePresenter(homeServices: HomeServices())
    var resp = [HomeData]()
    let categoryPresenter = NewsFeedPresenter(newsFeedServices: NewsFeedServices())
    var categoeryResp = [newsFeedData]()
    var videoUrl =  [String]()
    var dateArr =  [String]()
    var title_en =  [String]()
    var title_ta =  [String]()
    var descrip_en =  [String]()
    var descrip_ta =  [String]()
    var likeCount =  [String]()
    var shareCount =  [String]()
    var newsfeed_idArr =  [String]()
    var nf_cover_imageArr =  [String]()
    /*For Detail Page*/
    var eventTitle = String()
    var date = String()
    var likesCnt = String()
    var shareCnt = String()
    var descp = String()
    var newsfeed_id = String()
    var nf_cover_image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spvData = ["Your SPV","Gallery","Namakaaga Initiatives","Party"]
        self.tableView.backgroundColor = UIColor.white
        self.callAPI(from: "home", search_text: "no", categoery: "0", nf_category_id: "0" ,offset: "0", rowcount: "50")
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func callAPI(from:String,search_text: String, categoery:String, nf_category_id:String, offset:String, rowcount:String)
    {
        presenter.attachView(view: self)
        presenter.getHomeResp(from: from, search_text: search_text, categoery:categoery, nf_category_id: nf_category_id, offset: offset, rowcount: rowcount)
    }
    
    func callCategoeryNewsFeedID ()
    {
        categoryPresenter.attachView(view: self)
        categoryPresenter.getNewsFeed(user_id: "1")
    }
    
    func setNewsFeed(newsfeedValue: [newsFeedData]) {
        categoeryResp = newsfeedValue
        GlobalVariables.shared.localNewsId = categoeryResp[0].id
        GlobalVariables.shared.stateNewsId = categoeryResp[1].id
        GlobalVariables.shared.localEventsId = categoeryResp[2].id
        GlobalVariables.shared.stateEventsId = categoeryResp[3].id
        GlobalVariables.shared.socialInitiativesId = categoeryResp[4].id
        GlobalVariables.shared.nallarammTrustId = categoeryResp[5].id
    }
    
    @IBAction func chatButton(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_detail"){
            let vc = segue.destination as! HomePageDetail
            vc.newsfeed_id = self.newsfeed_id
            vc.nf_cover_image = self.nf_cover_image
            vc.eventTitle = self.eventTitle
            vc.date = self.date
            vc.likesCount = self.likesCnt
            vc.shareCount = self.shareCnt
            vc.descp = self.descp
            vc.fromView = "home"

        }
        if (segue.identifier == "to_yourSPV"){
            _ = segue.destination as! YourSpv
        }
        if (segue.identifier == "to_Party"){
            _ = segue.destination as! Party
        }
    }
}

extension Home: HomeView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource
{
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setHomeValues(homeResp: [HomeData]) {
        resp = homeResp
        for items in resp {
            let url = items.nf_video_token_id
            let date = items.news_date
            let title_en = items.title_en
            let title_ta = items.title_en
            let decrip_en = items.description_en
            let decrip_ta = items.description_ta
            let likecount = items.likes_count
            let sharecount = items.share_count
            let newsFeed_id = items.newsfeed_id
            let coverImage = items.nf_cover_image
            
            self.videoUrl.append(url ?? "")
            self.dateArr.append(date ?? "")
            self.title_en.append(title_en ?? "")
            self.title_ta.append(title_ta ?? "")
            self.descrip_en.append(decrip_en ?? "")
            self.descrip_ta.append(decrip_ta ?? "")
            self.likeCount.append(likecount ?? "")
            self.shareCount.append(sharecount ?? "")
            self.newsfeed_idArr.append(newsFeed_id ?? "")
            self.nf_cover_imageArr.append(coverImage ?? "")
        }
        self.tableView.reloadData()
        
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_en.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "dynamicCell", for: indexPath) as! HomeTableViewCell
         if LocalizationSystem.sharedInstance.getLanguage() == "en"{
            cell.titleText.text = title_en[indexPath.row]
            cell.descp.text = descrip_en[indexPath.row]
         }
         else
         {
            cell.titleText.text = title_ta[indexPath.row]
            cell.descp.text = descrip_ta[indexPath.row]
         }
        
         let formatedDate = self.formattedDateFromString(dateString: dateArr[indexPath.row], withFormat: "MMM dd, YYYY")
         cell.date.text = formatedDate
         cell.imgView.sd_setImage(with: URL(string: Globals.homePageImage + nf_cover_imageArr[indexPath.row]), placeholderImage: UIImage(named: ""))
         cell.shareOutlet.tag = indexPath.row
         cell.shareOutlet.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
         return cell
    }
    
    @objc func shareButtonClicked() {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if title_en.count > 20
        {
             let lastElement = title_en.count - 1
             print (lastElement)
             if indexPath.row == lastElement
             {
                  print("came to last row")
                  let lE = lastElement + 1
                  self.callAPI(from: "home", search_text: "no", categoery: "0", nf_category_id: "0" ,offset: String(lE), rowcount: "50")
             }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if LocalizationSystem.sharedInstance.getLanguage() == "en"
        {
            self.eventTitle = title_en[indexPath.row]
            self.descp = descrip_en[indexPath.row]
        }
        else
        {
            self.eventTitle = title_ta[indexPath.row]
            self.descp = descrip_ta[indexPath.row]
        }
        self.date = dateArr[indexPath.row]
        self.likesCnt = likeCount[indexPath.row]
        self.shareCnt = shareCount[indexPath.row]
        self.newsfeed_id = newsfeed_idArr[indexPath.row]
        self.nf_cover_image = newsfeed_idArr[indexPath.row]
        self.performSegue(withIdentifier: "to_detail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 323
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.chatView.alpha = 1.0
                //self?.chatView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        } else if lastContentOffset < scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.chatView.alpha = 0
                //self?.chatView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return spvData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        let leftColor =  UIColor(red: 5.0/255.0, green: 104.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        let rightColor =  UIColor(red: 3.0/255.0, green: 53.0/255.0, blue: 107.0/255.0, alpha: 1.0)
        cell.bgView.addGradient(colors:[leftColor,rightColor], locations: [0.0, 1.0])
        cell.textLabel.text = spvData[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
         cell.textLabel.text = spvData[indexPath.item]
         let width = self.estimatedFrame(text: cell.textLabel.text!, font: UIFont(name: "Lato-Regular", size: 13.0)!).width
         return CGSize(width: width, height: 50.0)
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0,left: 15,bottom: 0,right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let res = spvData[indexPath.row]
        print("You selected cell #\(indexPath.item)!")
        if indexPath.item == 0 {
            self.performSegue(withIdentifier: "to_yourSPV", sender: self)
        }
        if indexPath.item == 3 {
            self.performSegue(withIdentifier: "to_Party", sender: self)
        }
    }
}
