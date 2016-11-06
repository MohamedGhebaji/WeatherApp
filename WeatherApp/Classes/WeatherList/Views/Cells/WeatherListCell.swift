//
//  WeatherListCell.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit
import Haneke

class WeatherListCell: UICollectionViewCell {
    
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var temptureDescriptionLabel: UILabel!
    @IBOutlet private weak var temptureLabel: UILabel!
    @IBOutlet private weak var weatherTimeLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public Methods
    func configure(with weather: Weather) {
        //create the icon URL
        if let icon = weather.weatherIcon?.icon, let url = NSURL(string: Constants.API.iconBaseURL+icon+".png") {
            //laod the url image with Haneke, it's swifty lib used to cache the image with it's URL
            weatherIconImageView.hnk_setImageFromURL(url, placeholder: UIImage(named: "ic_nav_bar_paris"))
        }
        //set the weather description text
        temptureDescriptionLabel.text = weather.weatherIcon?.iconDescription
        //set the weather value : convert it to Celsius and add the degree unicode
        temptureLabel.text = "\(TemperatureConverter.kelvinToCelsius(weather.temp ?? 0))\u{00B0}"
        //set the weather time
        weatherTimeLabel.text = weather.weatherTime
    }
}
