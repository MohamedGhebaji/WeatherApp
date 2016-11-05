//
//  SplashViewControllerViewController.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var centerYImageConstriant: NSLayoutConstraint!
    @IBOutlet private weak var widthImageConstraint: NSLayoutConstraint!
    
    let openWeatherService = OpenWeatherMapService()
    var weathersList: [Weather]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openWeatherService.retrieveWeatherInfo(inCity: Constants.API.parisCityId) { (weathers, error) in
            if error != nil {
                self.weathersList = weathers
            } else {
                for cdWeather in CDWeather.findAll() {
                    self.weathersList.append(Weather(cdWeather: cdWeather))
                }
            }
            self.activityIndicator.stopAnimating()
            self.performImageAnimationWithCompletion({ 
                self.performSegueWithIdentifier(.GoToHome, sender: nil)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.GoToHome.rawValue {
           let navigationController = segue.destinationViewController as? UINavigationController
            (navigationController?.topViewController as? WeatherDaysListViewController)?.weathers = weathersList
        }
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    
    func performImageAnimationWithCompletion(completion: () -> ()) {
        centerYImageConstriant.active = false
        widthImageConstraint.constant = 35
        UIView.animateWithDuration(1.5, animations: {
            self.view.layoutIfNeeded()
            }) { (completed) in
                completion()
        }
    }
}

extension SplashViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case GoToHome
    }
}