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
    
    @Published var items = 0..<20
    
    let database = Firestore.firestore()
    
    @Published var contribution = 0
    @Published var target = 0
    
    @Published var listProjectMaterial = [ProjectMaterial]()
    
    func getProjectData() {
        
        
        
        database.collection("projects").getDocuments { snapshot, error in
            
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
    
    
    func getNumberOfContribution(projectId: String, completion: @escaping (Int) -> Void) {
        
        
        database.collection("contributions").whereField("projectId", isEqualTo: projectId).getDocuments { snapshot, error in
            if error ==  nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        completion(snapshot.documents.count)
                        
                    }
                    
                } else {
                    print("error")
                }
            }
            
        }
        
    }
    
    func getTotalNeeded(projectId: String) {
        
        
        database.collection("projectMaterials").whereField("projectId", isEqualTo: projectId).getDocuments { snapshot, error in
            if error ==  nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        
                        
                        self.listProjectMaterial = snapshot.documents.map { docs in
                            
                            
                            return ProjectMaterial(id: docs.documentID, materialName: docs["materialName"] as? String ?? "",
                                                   target: docs["target"] as? Int ?? 0,
                                                   strictLimitation: docs["strictLimitation"] as? Bool ?? false,
                                                   prerequisite: docs["prerequisite"] as? [String] ?? [""])
                            
                        }
                        
                       
                        
                        
                    }
                    
                } else {
                    print("error")
                }
            }
            
        }
       
    }
    
    func getProgesssOfContribution(projectId: String) -> Int {
        
        var progress = 0
        var needed = 0
       
        
        self.getNumberOfContribution(projectId: projectId) { contribution in
            self.contribution = contribution
        }
        
         self.getTotalNeeded(projectId: projectId)
        
        listProjectMaterial.forEach { material in
           
            needed +=  (material.target ?? 0)

        }
        

        
        
        progress =  needed - self.contribution
        
        return progress
    }
    
    
}
