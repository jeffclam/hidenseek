//
//  ChatViewController.swift
//  hideNSeek
//
//  Created by Rachel Chang on 11/9/17.
//  Copyright © 2017 jeffreylam. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    var barHeight: CGFloat = 50

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputBar: UIView!
    
    override var inputAccessoryView: UIView? {
        self.inputBar.frame.size.height = self.barHeight
        self.inputBar.clipsToBounds = true
        return self.inputBar
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
 
    func customization() {
        self.tableView.estimatedRowHeight = self.barHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset.bottom = self.barHeight
        self.tableView.scrollIndicatorInsets.bottom = self.barHeight
        self.navigationItem.title = "person"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
