//
//  SearchBarView.swift
//  Finewaste
//
//  Created by charlie siagian on 06/11/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    @Binding var isSearching : Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Project, material, lokasi...", text: $searchText)
                    .font(Fonts.poppinsSubheadline())
                    .padding(.leading, 24)
            }
            .padding()
            .frame(height: 36)
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 28)
                    .foregroundColor(Colors.Gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -0)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
            }
            
          
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""
    @State static var isSearching = false
    
    static var previews: some View {
        SearchBarView(searchText: $searchText, isSearching: $isSearching)
    }
}
