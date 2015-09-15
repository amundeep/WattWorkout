//
//  DetailViewController.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/3/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLastDate: UILabel!
    @IBOutlet weak var detailTitle: UINavigationItem!
    var detailItem = String()
    var detailDate = NSDate()
    var phText = "Last Updated: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        detailTitle.title = detailItem
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        detailLastDate.text = (phText + formatter.stringFromDate(detailDate))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

