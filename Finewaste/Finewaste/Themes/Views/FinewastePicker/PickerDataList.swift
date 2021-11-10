//
//  PickerDataList.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct PickerDataList: View {
    @Environment(\.presentationMode) var presentationMode
    var dataToChoose: [String]
    @Binding var selectedData: String
    
    var body: some View {
        List {
            ForEach(dataToChoose, id: \.self) { text in
                HStack {
                    Text(text)
                    Spacer()
                    if selectedData == text {
                        Image(systemName: "checkmark")
                            .font(.system(size: 18))
                            .foregroundColor(Colors.Turqoise)
                    }
                }
                .contentShape(Rectangle())
                .font(Fonts.poppinsSubheadline())
                .onTapGesture {
                    self.selectedData = text
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Delivery option")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton()
            }
        }
    }
}

struct PickerDataList_Previews: PreviewProvider {
    static var previews: some View {
        PickerDataList(dataToChoose: [], selectedData: .constant(""))
    }
}
