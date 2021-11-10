//
//  TimestampHelper.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFirestore

final class TimestampHelper {
    static let shared = TimestampHelper()
    
    private init() {}
    
    func daysBetween(date1: Timestamp, date2: Int) -> Int {
        let difference = date1.seconds - Int64(date2)
        
        let days = difference / 86400
        
        return Int(days)
    }
    
    func timestampToStringDate(timestamp: Timestamp) -> String {
        let seconds = timestamp.seconds
        
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy "
        
        return formatter.string(from: date)
    }
}
