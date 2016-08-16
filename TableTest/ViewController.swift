//
//  ViewController.swift
//  TableTest
//
//  Created by Gabriel Morales on 8/15/16.
//  Copyright © 2016 Gabemdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topTableConstraint: NSLayoutConstraint!
    @IBOutlet weak var table: UITableView!
    var topConstant: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupViews() {
        table.tableFooterView = UIView(frame: CGRectZero)
        table.separatorStyle = .None
        table.backgroundColor = .whiteColor()
        table.scrollEnabled = false
        table.registerNib(UINib.init(nibName: String(HeaderView), bundle: nil), forHeaderFooterViewReuseIdentifier: String(HeaderView))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onMoveToMiddle), name: "MoveToMiddle", object: nil)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        topConstant = CGRectGetHeight(self.view.bounds)-81
        if let constant = topConstant {
            topTableConstraint = NSLayoutConstraint(item: table, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: constant)
            self.view.addConstraint(topTableConstraint)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: table.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10, 10)).CGPath
        maskLayer.path = path
        table.layer.mask = maskLayer
    }
    
    func onMoveToMiddle() {
        self.view.layoutIfNeeded()
        var newConstant:CGFloat
        let originalConstant = CGRectGetHeight(self.view.bounds) - 81
        if self.topTableConstraint.constant == originalConstant {
            newConstant = 300.00
        } else {
            newConstant = originalConstant
        }
        
        self.topTableConstraint.constant = newConstant
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: .CurveEaseOut, animations: { 
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.table.scrollEnabled = newConstant < originalConstant ? true : false
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        cell.textLabel?.text = "Hello"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 81
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(HeaderView)) as! HeaderView
        header.configureHeaderWithTitle("Hello There")
        return header
    }
}

