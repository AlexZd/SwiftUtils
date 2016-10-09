//
//  NSDate+Helpers.swift
//
//  Created by Alex Zdorovets on 6/17/15.
//  Copyright (c) 2015 Alex Zdorovets. All rights reserved.
//

import Foundation

extension Date {
    public var dateOnly : Date {
        get {
            return self.toString("dd.MM.yyyy").toDate("dd.MM.yyyy")!
        }
    }
    
    public var isToday : Bool {
        get {
            return self.dateOnly == Date().dateOnly
        }
    }
    
    public var isYesterday : Bool{
        get {
            return self.dateOnly == Date().addingTimeInterval(-1 * 60 * 60 * 24).dateOnly
        }
    }
    
    public func dateWithShift(days:Int, months:Int, years:Int) -> Date? {
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        var components = Calendar.current.dateComponents(unitFlags, from: self)
        components.year = (components.year ?? 0) + years
        components.month = (components.month ?? 0) + months
        components.day = (components.day ?? 0) + days
        return Calendar.current.date(from: components)
    }
    
    /** Converts NSDate to String with mask format */
    public func toString(_ mask:String?) -> String {
        let dateFormatter = DateFormatter()
        if mask != nil {
            dateFormatter.dateFormat = mask
        }else{
            dateFormatter.timeStyle = .medium
            dateFormatter.dateStyle = .medium
        }
        
        return dateFormatter.string(from: self)
    }

    /** Converts NSDate to String with mask format in Gregorian format */
    public func toGregorianString(mask:String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        if mask != nil {
            dateFormatter.dateFormat = mask
        }else{
            dateFormatter.timeStyle = .medium
            dateFormatter.dateStyle = .medium
        }
        
        return dateFormatter.string(from: self)
    }
    
    public func dateTimeToFormatter(date:DateFormatter.Style, time:DateFormatter.Style) -> String {
        return DateFormatter(dateStyle: date, timeStyle: time).string(from: self)
    }
    
    public func dateTimeToGregorianFormatter(date:DateFormatter.Style, time:DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter(dateStyle: date, timeStyle: time)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
    
    public func dateToFormatter(formatter:DateFormatter.Style) -> String{
        return self.dateTimeToFormatter(date: formatter, time: .none)
    }
    
    public func dateToGregorianFormatter(formatter:DateFormatter.Style) -> String{
        return self.dateTimeToGregorianFormatter(date: formatter, time: .none)
    }
    
    public func timeToFormatter(formatter:DateFormatter.Style) -> String{
        return self.dateTimeToFormatter(date: .none, time:formatter)
    }
    
    public func timeToGregorianFormatter(formatter:DateFormatter.Style) -> String{
        return self.dateTimeToGregorianFormatter(date: .none, time:formatter)
    }
}