//
//  ExercisePickerView.swift
//  WattWorkout
//
//  Created by Sujay Patwardhan on 9/5/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import Foundation
import WatchKit
import UIKit
import CoreData

class ExercisePickerView: UIViewController{

    convenience init(){
        
        self.init()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("ExercisePickerView") as! UIViewController, animated: true)

    }
    

}