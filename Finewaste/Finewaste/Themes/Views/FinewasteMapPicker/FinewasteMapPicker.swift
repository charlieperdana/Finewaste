//
//  FinewasteMapPicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI
import MapKit

struct FinewasteMapPicker: View {
    var isReadOnly: Bool
    @Binding var currentAddress: String
    @Binding var currentCoordinate: CLLocationCoordinate2D
    var isShowingMap : Bool
    
    @State private var showMapScreen = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(currentAddress.isEmpty ? "Enter your address here" : currentAddress)
                    .foregroundColor(currentAddress.isEmpty ? Colors.PlaceholderGray : Colors.Black)
                Spacer()
                if !isReadOnly {
                    Image(systemName: "map")
                        .foregroundColor(Colors.Turqoise)
                        .font(.system(size: 22))
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.showMapScreen = true
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.Gray)
            )
            
            if isShowingMap{
                ZStack {
                    MapView(isVisualOnly: true, center: $currentCoordinate, visibleRegionChangeHandler: nil)
                        .frame(height: 200)
                        .cornerRadius(10)
                    
                    Image(systemName: "mappin")
                        .foregroundColor(Colors.Red)
                        .font(.system(size: 32))
                }
                .onTapGesture {
                    self.showMapScreen = true
                }
            }
            
            
            NavigationLink(destination: MapPinPointView(currentCoordinate: $currentCoordinate), isActive: $showMapScreen) {
                EmptyView()
            }
        }
    }
}

struct FinewasteMapPicker_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteMapPicker(isReadOnly: true, currentAddress: .constant(""), currentCoordinate: .constant(.init(latitude: 0, longitude: 0)), isShowingMap: true)
    }
}
