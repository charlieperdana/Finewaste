//
//  MapPinPointView.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI
import CoreLocation

struct MapPinPointView: View {
    @StateObject private var viewModel: MapPinPointViewModel
    @State private var searchText = ""
    @State private var isSearching = false
    @Binding private var lastSavedCoordinate: CLLocationCoordinate2D
    
    init(currentCoordinate: Binding<CLLocationCoordinate2D>) {
        self._viewModel = StateObject(wrappedValue: MapPinPointViewModel(coordinate: currentCoordinate.wrappedValue))
        self._lastSavedCoordinate = currentCoordinate
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    MapView(isVisualOnly: false, center: $viewModel.currentMapCenter) { center in
                        viewModel.latestMapCenter = center
                    }
                        .frame(height: geo.size.height / 2)
                    
                    VStack {
                        HStack {
                            CircleNavigationBackButton {
                                self.lastSavedCoordinate = viewModel.latestMapCenter
                            }
                                .offset(x: 16, y: 44)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            CircleCurrentLocationButton(onTapAction: viewModel.goToCurrentLocation)
                                .offset(x: -16, y: -11)
                        }
                    }
                    
                    Image(systemName: "mappin")
                        .foregroundColor(Colors.Red)
                        .font(.system(size: 32))
                }
                
                VStack(spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchQuery, isSearching: $isSearching, placeholderText: "Search address or location")
                    ZStack {
                        Rectangle()
                            .foregroundColor(Colors.SearchBarGray)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 6)
                            TextField("Search address or location", text: $viewModel.searchQuery)
                                .padding([.trailing, .top, .bottom])
                        }
                    }
                    .frame(height: 34)
                    .cornerRadius(10)
                    .padding()
                    
                    Divider()
                    List {
                        ForEach(viewModel.searchResultData) { data in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(data.title)
                                        .font(Fonts.poppinsBody())
                                    Text(data.subtitle)
                                        .font(Fonts.poppinsFootnote())
                                }
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.currentMapCenter = data.coordinate
                            }
                        }
                    }
                    .listStyle(.plain)
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
        MapPinPointView(currentCoordinate: .constant(CLLocationCoordinate2D(latitude: 0, longitude: 0)))
    }
}
