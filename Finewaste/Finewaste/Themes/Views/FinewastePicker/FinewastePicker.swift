//
//  FinewastePicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct FinewastePicker: View {
    var placeholder: String
    @Binding var selectedData: String
    var dataToChoose: [String]
    
    var body: some View {
        NavigationLink(destination: PickerDataList(dataToChoose: dataToChoose, selectedData: $selectedData)) {
            VStack(spacing: 11) {
                HStack {
                    if selectedData.isEmpty {
                        Text(placeholder)
                            .font(Fonts.poppinsSubheadline())
                            .foregroundColor(Colors.PlaceholderGray)
                    } else {
                        Text(selectedData)
                            .font(Fonts.poppinsSubheadline())
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Colors.Gray)
                }
                Divider()
            }
        }
    }
}

struct FinewastePicker_Previews: PreviewProvider {
    static var previews: some View {
        FinewastePicker(placeholder: "", selectedData: .constant(""), dataToChoose: [])
    }
}
