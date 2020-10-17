//
//  Date+Extensions.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/16.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

extension Date {
    
    var friendlyDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let dateComponets = Calendar.current.dateComponents([.day, .year], from: self)
        let month = dateFormatter.string(from: self)
        return month + " " + dateComponets.day!.description + " '" + dateComponets.year!.description.suffix(2)
    }
    
    var friendlyFullYearDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let dateComponets = Calendar.current.dateComponents([.day, .year, .hour, .minute], from: self)
        let month = dateFormatter.string(from: self)
        return month + " " + dateComponets.day!.description + " " + dateComponets.year!.description + " " + LocalizedCopy(named: "000-At") + " " + "\(dateComponets.hour!.description): \(String(format: "%02d", dateComponets.minute!))"
    }
    
}
