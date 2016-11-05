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
        let transition = CATransition()
        transition.duration = 1.5
        transition.type = kCATransitionFade;
        sourceViewController.view.window?.layer.addAnimation(transition, forKey: kCATransition)
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
    }
}