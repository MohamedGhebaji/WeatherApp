//
//  TabbarView.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

final class TabbarView: UIView {
    
    @IBOutlet private weak var tabbarCollectionView: UICollectionView!
    
    var delegate: TabbarViewDelegate?
    var dataSource: TabbarViewDataSource?
    var selectedIndexPath: NSIndexPath?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup the view
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup the view
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //register the tabbar item cell
        tabbarCollectionView.registerNib(UINib(nibName: String(TabbarCell), bundle: nil), forCellWithReuseIdentifier: String(TabbarCell))
        
    }
    
    // MARK: - Public Methods
    /**
     Reload the tabbar data (reload the collection view)
     */
    func reloadData() {
        //reload the collection view
        tabbarCollectionView?.reloadData()
    }
}

// MARK: - Private Methods
private extension TabbarView {
    
    /**
     Prepare the tabbar view
     */
    func commonInit() {
        //load the TabbarView view
        let tabbarView = NSBundle.mainBundle().loadNibNamed(String(TabbarView), owner: self, options: nil).first as! UIView
        //set the translates autoresizing mask to no
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        //add it to self
        addSubview(tabbarView)
        //create and add the h constraint
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tabbarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tabbarView":tabbarView])
        //create and add the v constraint
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tabbarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tabbarView":tabbarView])
        addConstraints(hConstraints)
        addConstraints(vConstraints)
    }
}

// MARK: - UICollectionViewDataSource
extension TabbarView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return the number of items or 0
        return dataSource?.numberOfItem() ?? 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //dequeue the tabbar item cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TabbarCell), forIndexPath: indexPath) as! TabbarCell
        //configure the cell with the title to show
        cell.configure(withTitle: dataSource?.tabbarView(self, titleOfItemAtIndex: indexPath.item) ?? "")
        //toogle the cell state, selected or NO
        cell.toogle(withState: selectedIndexPath != nil ? (indexPath == selectedIndexPath) : (indexPath.item == 0))
        //return the cell
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TabbarView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return the size of the cell
        return CGSize(width: 150, height: CGRectGetHeight(collectionView.frame))
    }
}
// MARK: - UICollectionViewDelegate
extension TabbarView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //save the selected index path
        selectedIndexPath = indexPath
        //relaod the collection view : not perfect
        //TODO : reload only the selected index path
        collectionView.reloadData()
        //fire the selection delegate with the tabbar object and the selected index
        delegate?.tabbarView?(self, didSelectItemAtIndex: indexPath.item)
    }
}

protocol TabbarViewDataSource {
    /**
     Return the number of tabbar items
     
     - returns: The number of the tabbar items
     */
    func numberOfItem() -> Int
    
    /**
     Return the title of the tabbar item at index
     
     - parameter tabbarView: The tabbar instance
     - parameter index:      The index of the tabbar item
     
     - returns: The title of the tabbar item
     */
    func tabbarView(tabbarView: TabbarView, titleOfItemAtIndex index: Int) -> String
}

@objc protocol TabbarViewDelegate {
    optional
    /**
     Fire the selection action with the selected index
     
     - parameter tabbarView: The tabbar instance
     - parameter index:      The selected index
     */
    func tabbarView(tabbarView: TabbarView, didSelectItemAtIndex index: Int)
}
