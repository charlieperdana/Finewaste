//
//  PostProjectUpdateView.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct PostProjectUpdateView: View {
    @StateObject var viewModel: PostProjectUpdateViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var projectUpdateText = ""
    @State private var selectedImages = [UIImage]()
    
    init(projectId: String) {
        self._viewModel = StateObject(wrappedValue: PostProjectUpdateViewModel(projectId: projectId))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment:. leading, spacing: 8) {
                    Text("Update Story")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "Tell us your project update", text: $projectUpdateText)
                }
                VStack(alignment:. leading, spacing: 8) {
                    Text("Product Image Reference")
                        .font(Fonts.poppinsCallout())
                    FinewasteImagePicker(selectedImages: $selectedImages)
                    
                }
                Spacer()
            }
            .padding()
    
            .navigationTitle("Post Update")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Colors.Turqoise)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.postUpdate(updateDescription: projectUpdateText, images: selectedImages)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Post")
                            .foregroundColor(Colors.Turqoise)
                    }
                }
            }
        }
    }
}

struct PostProjectUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        PostProjectUpdateView(projectId: "")
    }
}
