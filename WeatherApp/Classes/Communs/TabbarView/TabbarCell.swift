//
//  TabbarCell.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

class TabbarCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Public Methods
    func configure(withTitle title: String) {
        titleLabel.text = title
    }
    
    func toogle(withState selected: Bool) {
        indicatorView.hidden = !selected
        titleLabel.textColor = selected ? UIColor(hex: 0xEC008C) : UIColor(hex: 0xAEA79F)
    }
}
