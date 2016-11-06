//
//  FadeInSegue.swift
//  WeatherApp
//
//  Created by Mohamed on 05/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit
class FadeInSegue: UIStoryboardSegue {
    override func perform() {
        //create a fade out animation when transioning from splash to home vc
        //first we create the CATransition animation object
        let transition = CATransition()
        //set the animation duration
        transition.duration = 1.5
        //set the transition type
        transition.type = kCATransitionFade;
        //add the transition animation to the splash layer
        sourceViewController.view.window?.layer.addAnimation(transition, forKey: kCATransition)
        //present the home vc with no animation
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
    }
}