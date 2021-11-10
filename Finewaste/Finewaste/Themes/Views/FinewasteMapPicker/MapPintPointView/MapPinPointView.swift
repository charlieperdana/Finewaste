//
//  MapPinPointView.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI

struct MapPinPointView: View {
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    MapView(isVisualOnly: false)
                        .frame(height: geo.size.height / 2)
                    
                    VStack {
                        HStack {
                            CircleNavigationBackButton()
                                .offset(x: 16, y: 44)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            CircleCurrentLocationButton(onTapAction: {})
                                .offset(x: -16, y: -11)
                        }
                    }
                    
                    Image(systemName: "mappin")
                        .foregroundColor(Colors.Red)
                        .font(.system(size: 32))
                }
                
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Colors.SearchBarGray)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 6)
                            TextField("Search address or location", text: $searchText)
                                .padding([.trailing, .top, .bottom])
                        }
                    }
                    .frame(height: 34)
                    .cornerRadius(10)
                    .padding()
                    
                    Divider()
                    Text("Listnya..")
                    Spacer()
                }
                .frame(height: geo.size.height / 2)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct MapPinPointView_Previews: PreviewProvider {
    static var previews: some View {
        MapPinPointView()
    }
}
