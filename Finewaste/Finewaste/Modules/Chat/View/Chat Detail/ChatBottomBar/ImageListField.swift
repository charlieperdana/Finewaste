//
//  ImageListField.swift
//  Finewaste
//
//  Created by Andrean Lay on 01/12/21.
//

import SwiftUI

struct ImageListField: View {
    @Binding var selectedImages: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(selectedImages.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: selectedImages[index])
                            .resizable()
                            .frame(width: 109, height: 145)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Button {
                            self.removeImage(at: index)
                        } label: {
                            Image("deleteIcon")
                                .foregroundColor(Colors.Red)
                                .font(.system(size: 17))
                        }
                        .offset(x: 7, y: -7)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Colors.PlaceholderGray)
        )
    }
    
    private func removeImage(at index: Int) {
        withAnimation {
            self.selectedImages.remove(at: index)
        }
    }
}

struct ImageListField_Previews: PreviewProvider {
    static var previews: some View {
        ImageListField(selectedImages: .constant([]))
    }
}
