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
    @IBOutlet private var collectionView: UICollectionView!
    
    let openWeatherService = OpenWeatherMapService()
    var weathers: (weathers: [Weather], shouldSaveData: Bool)!
    var viewModel: WeatherDaysListViewModel?
    var selectedDayIndex = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //set the title view icon, there is many way to do it : 
        // 1. Create a base class and it in the base class and then all the others classes should inherit from the base class to have the functiionaly (not very good in swift ==> Not very swifty)
        // 2. Use a protocol that define the functioanty in the protocol extension and the any vc whant to have the icon, conforme to the protocl : swifty and good
        // 3. Use of the viewController swizzling, not bad also, less code
        navigationItem.titleView = UIImageView(image: UIImage(named: "ic_nav_bar_paris"))
        //setup the view
        setupView()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        //update the size of cells after rotating the device
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //check if the sender is of type Box<Weather> and the segue identifier is equal to GoToDetails enum raw value
        if let weatherBox = sender as? Box<Weather> where segue.identifier == SegueIdentifier.GoToDetails.rawValue {
            //get the destination view controller
            let weatherDetailsViewController = segue.destinationViewController as? WeatherDetailsViewController
            //set the weather objects after unboxing
            weatherDetailsViewController?.weather = weatherBox.unbox
        }
    }
}

// MARK: - Private Methods
private extension WeatherDaysListViewController {
    func setupView() {
        //set the tabbar dataSource and delegate, i tried to do it with IBOutlet but it didn't worked with swift ...
        //TODO : Use IBOutlet to set the delegate and the dataSource
        self.tabbarView.dataSource = self
        self.tabbarView.delegate = self
        //create the weather list view model
        viewModel = WeatherDaysListViewModel(weathers: weathers.weathers, shoudlSave: weathers.shouldSaveData)
        //reload the tabbar
        tabbarView.reloadData()
    }
}

// MARK: - TabbarViewDataSource & TabbarViewDelegate
extension WeatherDaysListViewController: TabbarViewDataSource, TabbarViewDelegate {
    func numberOfItem() -> Int {
        //return the number of items or 0
        return viewModel?.tabbarItems.count ?? 0
    }
    
    func tabbarView(tabbarView: TabbarView, titleOfItemAtIndex index: Int) -> String {
        //return the title of item or empty
        return viewModel?.tabbarItems[index] ?? ""
    }
    
    func tabbarView(tabbarView: TabbarView, didSelectItemAtIndex index: Int) {
        //save the selected index (it will be used in the UICollectionViewDataSource)
        selectedDayIndex = index
        //reload the collection view
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension WeatherDaysListViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return the number of items or 0
        return viewModel?.daysWeatherList[selectedDayIndex].count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //dequeue the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(WeatherListCell), forIndexPath: indexPath) as! WeatherListCell
        if let weather = viewModel?.daysWeatherList[selectedDayIndex][indexPath.item] {
            //configure it with the weather object
            cell.configure(with: weather)
        }
        //return the cell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherDaysListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return the size of the cell, full screen width and 150pt hieght
        return CGSize(width: CGRectGetWidth(collectionView.frame), height: 150.0)
    }
}

// MARK: - UICollectionViewDelegate
extension WeatherDaysListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //get the selected weather object
        if let selectedWeather = viewModel?.daysWeatherList[selectedDayIndex][indexPath.item] {
            //perform the segue with the Boxed value type
            //we can't send value type (struct) to method that accept reference type so i have to box it in reference type and unboxing it in the prepareForSegue method
            performSegueWithIdentifier(.GoToDetails, sender: Box(selectedWeather))
        }
    }
}

// MARK: - SegueHandlerType
extension WeatherDaysListViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case GoToDetails
    }
}
