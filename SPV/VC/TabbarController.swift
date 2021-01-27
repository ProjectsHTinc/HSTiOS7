//
//  TabbarController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class TabbarController: UITabBarController, UITabBarControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate, NewsFeedView {

    @IBOutlet weak var menuOutlet: UIBarButtonItem!
    @IBOutlet weak var languageOutlet: UIBarButtonItem!
    @IBOutlet weak var searchOutlet: UIBarButtonItem!
    @IBOutlet weak var notificationOutlet: UIBarButtonItem!
                   
    var searchBar = UISearchController()
    var NewsFeed = NewsFeedPresenter(newsFeedServices: NewsFeedServices())
    var NewsFeedData = [newsFeedData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Tabbar border width*/
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.setGradientBackground(colors: [UIColor(red: 3.0/255.0, green: 53.0/255.0, blue: 107.0/255.0, alpha: 1.0),UIColor(red: 5.0/255.0, green: 104.0/255.0, blue: 214.0/255.0, alpha: 1.0)], startPoint: .topLeft, endPoint: .bottomRight)
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 10)!], for: .selected)
        callWebservices()
    }
    
    func callWebservices (){
        NewsFeed.attachView(view: self)
        NewsFeed.getNewsFeed(user_id:"1")
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setNewsFeed(newsfeedValue: [newsFeedData]) {
        NewsFeedData = newsfeedValue
        GlobalVariables.shared.localNewsId = NewsFeedData[0].id
        GlobalVariables.shared.stateNewsId = NewsFeedData[1].id
        GlobalVariables.shared.localEventsId = NewsFeedData[2].id
        GlobalVariables.shared.stateEventsId = NewsFeedData[3].id
        GlobalVariables.shared.socialInitiativesId = NewsFeedData[4].id
        GlobalVariables.shared.nallarammTrustId = NewsFeedData[5].id
        
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }


    @IBAction func menu(_ sender: Any) {
        
    }
    
    @IBAction func language(_ sender: Any) {
        
    }
    
    @IBAction func search(_ sender: Any) {
        createSearchBar()
    }
    
    func createSearchBar()
    {
        searchBar = UISearchController(searchResultsController: nil)
        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.keyboardType = UIKeyboardType.asciiCapable
        //searchBar.searchResultsUpdater = self
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.definesPresentationContext = true
        //SearchController Customization
        searchBar.searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.searchBar.barTintColor = UIColor(red: 3.0/255.0, green: 53.0/255.0, blue: 107.0/255.0, alpha: 1.0)
        UISearchBar.appearance().tintColor = .white
        // Make this class the delegate and present the search
        self.searchBar.searchBar.delegate = self
        self.navigationController?.present(searchBar, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        self.performSegue(withIdentifier: "to_Search", sender: searchBar.text)
        self.searchBar.isActive = false
    }
    
    @IBAction func notification(_ sender: Any) {
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_Search")
        {
//            let vc = segue.destination as! Search
//            vc.keyword = sender as! String
        }
    }
    

}

class UINavigationBarGradientView: UIView {
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
                case .topRight: return CGPoint(x: 1, y: 0)
                case .topLeft: return CGPoint(x: 0, y: 0)
                case .bottomRight: return CGPoint(x: 1, y: 1)
                case .bottomLeft: return CGPoint(x: 0, y: 1)
                case .custom(let point): return point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = frame
        superview?.addSubview(self)
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor],
                               startPoint: UINavigationBarGradientView.Point = .topLeft,
                               endPoint: UINavigationBarGradientView.Point = .bottomLeft,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(colors: colors, startPoint: startPoint,
                                                           endPoint: endPoint, locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
}
