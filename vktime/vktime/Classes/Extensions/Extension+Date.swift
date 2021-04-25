//
//  Extension+Date.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "GMT") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone.current
        components.hour = hour
        components.minute = min
        components.second = sec

        return cal.date(from: components)
    }
    
    var weekday: Int {
        let calendar = Calendar.current.component(.weekday, from: self)
        return calendar
    }
    
    var minute: Int {
        let calendar = Calendar.current.component(.minute, from: self)
        return calendar
    }
    
    var seconds: Int {
        let calendar = Calendar.current.component(.second, from: self)
        return calendar
    }
    
    var hours: Int {
        let calendar = Calendar.current.component(.hour, from: self)
        return calendar
    }
}
