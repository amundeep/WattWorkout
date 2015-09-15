//
//  Workout.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/4/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import UIKit

class Workout: NSObject {
    
    var type: String
    var name: String
    var value: Double
    var datemod: NSDate
    
    
    
    init(wType: String, wName: String, cValue: Double, wDate: NSDate){
        type = wType
        name = wName
        value = cValue
        datemod =  wDate
        super.init()
    }
   
}
