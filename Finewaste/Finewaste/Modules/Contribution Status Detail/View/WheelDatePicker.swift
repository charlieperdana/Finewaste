//
//  WheelDatePicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 21/11/21.
//

import SwiftUI
import FirebaseFirestore

struct WheelDatePicker: View {
    var datesList: [Timestamp]
    @Binding var selectedDate: Timestamp
    var cancelOnTap: () -> Void
    var doneOnTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") {
                    cancelOnTap()
                }
                .font(Fonts.poppinsBody())
                .padding()
                
                Spacer()
                
                Button("Done") {
                    doneOnTap()
                }
                .foregroundColor(Colors.Turqoise)
                .font(Fonts.poppinsHeadline())
                .padding()
            }
            Divider()
            
            Picker("", selection: $selectedDate) {
                ForEach(datesList, id: \.self) { date in
                    Text(
                        TimestampHelper.shared.timestampToStringDate(timestamp: date, format: .dayDate))
                        .tag(date)
                        .font(.system(size: 17))
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
        }
        .background(Color.white)
        .frame(height: 250)
        .clipped()
    }
}

struct WheelDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        WheelDatePicker(datesList: [], selectedDate: .constant(Timestamp(seconds: 0, nanoseconds: 0)), cancelOnTap: {}, doneOnTap: {})
    }
}
