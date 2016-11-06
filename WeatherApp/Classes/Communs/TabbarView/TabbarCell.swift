//
//  TabbarCell.swift
//  WeatherApp
//
//  Created by Mohamed on 03/11/2016.
//  Copyright © 2016 Mohamed. All rights reserved.
//

import UIKit

final class TabbarCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Public Methods
    
    /**
     Configure the cell with the title value
     
     - parameter title: The title to show or nil
     */
    func configure(withTitle title: String) {
        //set the title
        titleLabel.text = title
    }
    
    /**
     Toogle the cell status
     
     - parameter selected: true to show the selected state, false otherwise
     */
    func toogle(withState selected: Bool) {
        //show the indicator if the cell is selected or hide it otherwise
        indicatorView.hidden = !selected
        //change the title label 's text color
        titleLabel.textColor = selected ? UIColor(red: 7, green: 151, blue: 234) : UIColor(hex: 0xAEA79F)
    }
}
