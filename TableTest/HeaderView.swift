//
//  HeaderView.swift
//  TableTest
//
//  Created by Gabriel Morales on 8/15/16.
//  Copyright © 2016 Gabemdev. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerTitleLabel.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1)
        
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 2
        self.layer.shadowPath = shadowPath.CGPath
        
        headerTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onMoveToMiddle))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    final func configureHeaderWithTitle(title: String) {
        headerTitleLabel.text = title
    }
    
    func onMoveToMiddle() {
        NSNotificationCenter.defaultCenter().postNotificationName("MoveToMiddle", object: nil)
    }
}
