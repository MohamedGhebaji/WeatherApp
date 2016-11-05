//
//  TabbarView.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

class TabbarView: UIView {
    
    @IBOutlet private weak var tabbarCollectionView: UICollectionView!
    
    var delegate: TabbarViewDelegate?
    var dataSource: TabbarViewDataSource?
    var selectedIndexPath: NSIndexPath?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabbarCollectionView.registerNib(UINib(nibName: String(TabbarCell), bundle: nil), forCellWithReuseIdentifier: String(TabbarCell))
        
    }
    
    // MARK: - Public Methods
    func reloadData() {
        tabbarCollectionView?.reloadData()
    }
}

// MARK: - Private Methods
private extension TabbarView {
    func commonInit() {
        let tabbarView = NSBundle.mainBundle().loadNibNamed(String(TabbarView), owner: self, options: nil).first as! UIView
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tabbarView)
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tabbarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tabbarView":tabbarView])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[tabbarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tabbarView":tabbarView])
        addConstraints(hConstraints)
        addConstraints(vConstraints)
    }
}

// MARK: - UICollectionViewDataSource
extension TabbarView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItem() ?? 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(TabbarCell), forIndexPath: indexPath) as! TabbarCell
        cell.configure(withTitle: dataSource?.tabbarView(self, titleOfItemAtIndex: indexPath.item) ?? "")
        cell.toogle(withState: selectedIndexPath != nil ? (indexPath == selectedIndexPath) : (indexPath.item == 0))
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TabbarView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: CGRectGetHeight(collectionView.frame))
    }
}
// MARK: - UICollectionViewDelegate
extension TabbarView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
        delegate?.tabbarView?(self, didSelectItemAtIndex: indexPath.item)
    }
}

protocol TabbarViewDataSource {
    func numberOfItem() -> Int
    func tabbarView(tabbarView: TabbarView, titleOfItemAtIndex index: Int) -> String
}

@objc protocol TabbarViewDelegate {
    optional
    func tabbarView(tabbarView: TabbarView, didSelectItemAtIndex index: Int)
}
