//
//  ProjectViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 04/11/21.
//

import Foundation
import Firebase
import SwiftUI

class ProjectViewModel: ObservableObject {
    
    @Published var listProject = [Project]()
    
    
    func getProjectData() {
        
        let db = Firestore.firestore()
        
        db.collection("projects").getDocuments { snapshot, error in
            
            if error ==  nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        self.listProject = snapshot.documents.map { docs in
                            
                            
                            return Project(id: docs.documentID,
                                           poster: docs["poster"] as? String ?? "",
                                           projectName: docs["projectName"] as? String ?? "",
                                           description: docs["description"] as? String ?? "",
                                           deadline: docs["deadline"] as? Int ?? 0,
                                           neededMaterials: docs["neededMaterials"] as? [ProjectMaterial] ?? [ProjectMaterial()],
                                           images: docs["images"] as? [String] ?? [""],
                                           deliveryType: docs["deliveryType"] as? [String] ?? [""],
                                           location: docs["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                           updates: docs["updates"] as? [ProjectUpdate] ?? [ProjectUpdate()])
                            
                        }
                    }
                    
                }
            }
            else {
                
            }
        }
        
    }
    
}
