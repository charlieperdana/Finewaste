//
//  FinewasteSearchbar.swift
//  Finewaste
//
//  Created by Andrean Lay on 23/11/21.
//

import SwiftUI

struct FinewasteSearchbar: View {
    var placeholderText: String
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField(placeholderText, text: $searchText)
                .font(Fonts.poppinsSubheadline())
                .padding(.leading, 24)
        }
        .padding()
        .frame(height: 36)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                Spacer()
            }.padding(.horizontal, 28)
                .foregroundColor(Colors.Gray)
        )
    }
}

struct FinewasteSearchbar_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteSearchbar(placeholderText: "", searchText: .constant(""))
    }
}
