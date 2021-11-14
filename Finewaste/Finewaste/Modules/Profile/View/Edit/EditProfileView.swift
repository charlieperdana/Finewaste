//
//  EditProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 14/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct EditProfileView: View {
    
    @State private var nameText = ""
    
    @State private var descText = ""
    
    private var placeholderDesc = "e.g. I am an upcycler specializing in denim upcycling, chat me if you would like to colaborate!"
    
    let textLimit = 500
    
    @State private var isUpcycler : Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ScrollViewReader { value in
                    VStack(spacing:16) {
                        WebImage(url: URL(string: ("https://firebasestorage.googleapis.com/v0/b/finewaste.appspot.com/o/Profile%20Pic.svg?alt=media&token=63062364-4414-4d84-bb83-7a766f4aaa57")))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                        
                        FinewasteRoundedOutlineButton(text: "Change Profile Image", size: .fullWidth) {
                            
                        }
                        
                        
                        VStack(alignment:.leading, spacing:3) {
                            Text("Name")
                                .font(Fonts.poppinsCallout())
                            FinewasteTextField(placeholder: "e.g. Jonathan", text: $nameText)
                        }
                        
                        VStack(alignment:.leading, spacing:3) {
                            Text("Username")
                                .font(Fonts.poppinsCallout())
                            FinewasteTextField(placeholder: "e.g. jonathan_123", text: $nameText)
                        }
                        
                        VStack(alignment:.leading, spacing:3) {
                            Text("Project Address")
                                .font(Fonts.poppinsCallout())
                            Text("Your full address will not be shown on your profile")
                                .font(Fonts.poppinsCaption())
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Colors.Gray)
                                TextField("Type your adreess here...", text: $nameText)
                                    .font(Fonts.poppinsSubheadline())
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 12)
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "map")
                                        .foregroundColor(Colors.Turqoise)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                }
                                .padding()
                                
                            }
                            .frame(height: 58)
                        }
                        
                        VStack(alignment:.leading, spacing:3) {
                            Text("Description")
                                .font(Fonts.poppinsCallout())
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Colors.Gray)
                                
                                
                                TextEditor(text: $descText)
                                    .font(Fonts.poppinsSubheadline())
                                //                                .foregroundColor(self.descText == self.placeholderDesc ? .gray :.primary)
                                //                                .onTapGesture {
                                //                                    if self.descText == self.placeholderDesc {
                                //                                        self.descText = ""
                                //                                    }
                                //                                }
                                    .padding([.leading, .trailing], 16)
                                    .padding([.top, .bottom], 12)
                                    .onReceive(Just(descText)) { _ in limitDescText(textLimit) }
                                
                                
                            }
                            .frame(height: 98)
                            
                            Text("\(descText.count)/500")
                                .font(Fonts.poppinsFootnote())
                                .foregroundColor(Colors.Turqoise)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                            
                        }
                        
                        VStack() {
                            Toggle(isOn: $isUpcycler){
                                Text("Are you an Upcycler")
                                    .font(Fonts.poppinsCallout())
                            }.onChange(of: isUpcycler) { isUp in
                                if isUp {
//                                    value.scrollTo(8)
                                }
                            }
                            
                        }
                        
                        if isUpcycler {
                            UpcyclerActiveView()
                        }
                        
                    }
                }
                
                
                
                
            }
            .padding()
            .navigationTitle(Text("Edit Profile"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    HStack {
                Button {
                    
                } label: {
                    Text("Cancel").font(Fonts.poppinsBody()).foregroundColor(Colors.Turqoise)
                }
            }
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Done").font(Fonts.poppinsBody()).foregroundColor(Colors.Gray)
                    }
                    
                    
                }
            }
        }
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 17)!]
    }
    
    func limitDescText(_ upper: Int) {
        if descText.count > upper {
            descText = String(descText.prefix(upper))
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
