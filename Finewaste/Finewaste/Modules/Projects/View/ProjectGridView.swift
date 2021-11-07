//
//  ProjectGridView.swift
//  Finewaste
//
//  Created by charlie siagian on 08/11/21.
//

import SwiftUI

struct ProjectGridView: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200),spacing: 20),
            GridItem(.flexible(minimum: 100, maximum: 200))
//            GridItem(.fixed(100))
        ], spacing: 12, content: {
            ForEach(0..<20, id: \.self){ num in
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(width: 140, height: 140)
                        .background(Colors.Red)
                    Text("Product Name")
                    Text("Progess")
                    Spacer()

                }
                .padding()
                .background(Colors.Pink)
            }
        }).padding(.horizontal)
    }
}

struct ProjectGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectGridView()
    }
}
