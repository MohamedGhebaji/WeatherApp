//
//  WeatherDaysListViewController.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

final class WeatherDaysListViewController: UIViewController {
    
    @IBOutlet private var tabbarView: TabbarView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    let openWeatherService = OpenWeatherMapService()
    var weathers: [Weather]!
    var viewModel: WeatherDaysListViewModel?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        navigationItem.titleView = UIImageView(image: UIImage(named: "ic_nav_bar_paris"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - Private Methods
private extension WeatherDaysListViewController {
    func setupView() {
        self.tabbarView.dataSource = self
        self.tabbarView.delegate = self
        viewModel = WeatherDaysListViewModel(weathers: weathers)
        tabbarView.reloadData()
    }
}

// MARK: - TabbarViewDataSource & TabbarViewDelegate
extension WeatherDaysListViewController: TabbarViewDataSource, TabbarViewDelegate {
    func numberOfItem() -> Int {
        return viewModel?.tabbarItems.count ?? 0
    }
    
    func tabbarView(tabbarView: TabbarView, titleOfItemAtIndex index: Int) -> String {
        return viewModel?.tabbarItems[index] ?? ""
    }
    
    func tabbarView(tabbarView: TabbarView, didSelectItemAtIndex index: Int) {
        
    }
}