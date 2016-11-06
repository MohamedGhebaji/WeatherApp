//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    var weather: Weather?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set the title view icon, there is many way to do it :
        // 1. Create a base class and it in the base class and then all the others classes should inherit from the base class to have the functiionaly (not very good in swift ==> Not very swifty)
        // 2. Use a protocol that define the functioanty in the protocol extension and the any vc whant to have the icon, conforme to the protocl : swifty and good
        // 3. Use of the viewController swizzling, not bad also, less code
        navigationItem.titleView = UIImageView(image: UIImage(named: "ic_nav_bar_paris"))
    }
}
