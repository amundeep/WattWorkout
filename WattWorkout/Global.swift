//
//  TableData.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/4/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//


class Global {
    
    var tableData = [Workout]()
    
    init(data:[Workout]){
        self.tableData = data
    }
    
}

//Grab from userdefaults and place here

var globalVar = Global(data: [])