//
//  TimestampHelper.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFirestore

enum DateFormat: String {
    case simple = "d MMMM yyyy"
    case full = ""
}

final class TimestampHelper {
    static let shared = TimestampHelper()
    
    private init() {}
    
    func daysBetween(date1: Timestamp, date2: Int) -> Int {
        let difference = date1.seconds - Int64(date2)
        
        let days = difference / 86400
        
        return Int(days)
    }
    
    func timestampToStringDate(timestamp: Timestamp, format: DateFormat) -> String {
        let seconds = timestamp.seconds
        
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        
        let formatter = DateFormatter()
        if format == .simple {
            formatter.dateFormat = "d MMMM yyyy "
        } else if format == .full {
            formatter.dateFormat = "EEEE, d MMMM yyyy, h:mm a"
        }
        
        return formatter.string(from: date)
    }
    
    func addThreeDaysTo(timestamp: Timestamp) -> Timestamp {
        let secondsInThreeDays: Int64 = 259200
        
        return Timestamp(seconds: timestamp.seconds + secondsInThreeDays, nanoseconds: 0)
    }
}
