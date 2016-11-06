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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //retrieve the weather info from the ws
        openWeatherService.retrieveWeatherInfo(inCity: Constants.API.parisCityId) { (weathers, error) in
            //the completion block will return a list the Weather object or error
            var weathersList: APIResponse
            if error == nil {
                //if no error we save the returned weathers
                //must save or resave the data when get response from API
                weathersList = APIResponse(weathers: weathers, shouldSaveData: true)
            } else {
                var weathers = [Weather]()
                //if error, we retrieve the saved weather
                for cdWeather in CDWeather.findAll() {
                    //create the struct object from the core data object ==> must never use directly the core data object
                    weathers.append(Weather(cdWeather: cdWeather))
                }
                //must not resave the save the data when get it from cache (core data)
                weathersList = APIResponse(weathers: weathers, shouldSaveData: false)
            }
            //stop the loading indicator view (it will be hided auto)
            self.activityIndicator.stopAnimating()
            //perform the logo transition to top animation
            self.performImageAnimationWithCompletion({
                //go to home after the end of the transition animation
                //we can't send value type (struct) to method that accept reference type so i have to box it in reference type and unboxing it in the prepareForSegue method
                self.performSegueWithIdentifier(.GoToHome, sender: Box(weathersList))
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //check if the segue is the GoToHome
        //i don't like the use of the segue to make transiotion between the vc, but here only for a demo app i use it
        //generally i use the coordinator class which handle the transiotion between the vc
        //see here for more details : http://khanlou.com/2015/01/the-coordinator/
        if let weatherListBox = sender as? Box<APIResponse> where segue.identifier == SegueIdentifier.GoToHome.rawValue {
            //retrieve the destination vc
           let navigationController = segue.destinationViewController as? UINavigationController
            //set the weather list after unboxing
            (navigationController?.topViewController as? WeatherDaysListViewController)?.weathers = (weathers: weatherListBox.unbox.weathers, shouldSaveData: weatherListBox.unbox.shouldSaveData)
        }
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    
    func performImageAnimationWithCompletion(completion: () -> ()) {
        //to make the animation transiotion, i will play with constraint
        //desactivate the center y constraint
        centerYImageConstriant.active = false
        //update the value of the widht constraint
        widthImageConstraint.constant = 35
        UIView.animateWithDuration(1.5, animations: {
            //animate the constraint
            self.view.layoutIfNeeded()
            }) { (completed) in
                //fire the completion block
                completion()
        }
    }
}

extension SplashViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case GoToHome
    }
}

struct APIResponse {
    let weathers: [Weather]
    let shouldSaveData: Bool
}