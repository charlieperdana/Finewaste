//
//  UnixTimestampHelper.swift
//  Finewaste
//
//  Created by Andrean Lay on 29/11/21.
//

import Foundation

final class UnixTimestampHelper {
    static let shared = UnixTimestampHelper()
    
    private init() {
        
    }
    
    func unixTimestampToString(seconds: Int64, format: FinewasteDateFormat) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds / 1000))
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        let formattedTime = formatter.string(from: date)
        
        return formattedTime
    }
}
