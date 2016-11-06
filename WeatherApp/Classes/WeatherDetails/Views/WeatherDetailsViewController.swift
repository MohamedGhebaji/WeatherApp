//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Mohamed on 06/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit
import Haneke

final class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var temptureDescriptionLabel: UILabel!
    @IBOutlet private weak var temptureLabel: UILabel!
    @IBOutlet private weak var weatherTimeLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var tempMinLabel: UILabel!
    @IBOutlet private weak var pressionLabel: UILabel!
    @IBOutlet private weak var seaLevelLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    
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
        //create the details vm
        if let weather = weather {
            let viewModel = WeatherDetailsViewModel(weather: weather)
            //check if the icon URL is not nil
            if let iconURL = viewModel.weatherIconURL {
                //load the icon by URL, and cache the image
                weatherIconImageView.hnk_setImageFromURL(iconURL, placeholder: UIImage(named: "ic_nav_bar_paris"))
            } else {
                //set the default image if not possible
                weatherIconImageView.image = UIImage(named: "ic_nav_bar_paris")
            }
            //set the weather description content
            temptureDescriptionLabel.text = viewModel.weatherDescription
            //set the tempture content
            temptureLabel.text = viewModel.temp
            //set the weather time content
            weatherTimeLabel.text = viewModel.weatherTime
            //set the humidity content
            humidityLabel.text = viewModel.humidity
            //set the temp max content
            tempMaxLabel.text = viewModel.tempMax
            //set the temp min content
            tempMinLabel.text = viewModel.tempMin
            //set the pression content
            pressionLabel.text = viewModel.pression
            //set the sea level value
            seaLevelLabel.text = viewModel.seaLevel
            //set the wind value
            windLabel.text = viewModel.wind
        }
    }
}
