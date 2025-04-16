//
//  Date+Formatting.swift
//  Sofa
//
//  Created by Akademija on 10.04.2025..
//

import Foundation

extension Date {
    var hourMinute: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    var dayMonthYearTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy. \nHH:mm"
        return formatter.string(from: self)
    }
}

