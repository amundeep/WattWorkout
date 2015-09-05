//
//  InterfaceController.swift
//  WattWorkout WatchKit Extension
//
//  Created by Amundeep Singh on 9/3/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        println("Fucking debug shit")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        println("Fucking debug shit")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        println("Fucking debug shit")
    }
    
    @IBOutlet weak var TestingLabel: WKInterfaceLabel!

    @IBAction func showNewEntryPage() {
        TestingLabel.setText("Fucking debug shit")
        println("Fucking debug shit")
        pushControllerWithName("ExercisePickerView", context: nil)
    }

}
