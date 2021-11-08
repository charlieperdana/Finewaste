//
//  CloudFunctionTrigger.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import FirebaseFunctions

final class CloudFunctionTrigger {
    static let shared = CloudFunctionTrigger()
    
    private init() {}
    
    func getServerTime(completion: @escaping (Int) -> Void) {
        Functions.functions().httpsCallable("serverTime").call { result, error in
            if error != nil {
                return
            }
            
            if let unixTimestamp = (result?.data as? [String: Any])?["_seconds"] as? Int {
                completion(unixTimestamp)
            }
        }
    }
}
