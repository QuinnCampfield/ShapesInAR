//
//  HelpView.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/23/24.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Instructions")
            .font(.title)
            .padding()
        VStack(alignment: .leading) {
            
            Text("- The left 4 buttons are the main tools. From top to bottom there is Sphere tool, Cube tool, Eraser and Trash all.")
            Text("- The right 3 buttons are color selections for the created objects.")
            Text("- The bottom slider is for how large the objects will be.")
        }
        .frame(maxWidth: 250, alignment: .leading)
        .padding(.vertical)
        VStack {
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title2)
            .padding()
            .background(.black)
        }
        .padding()
    }
}

#Preview {
    HelpView()
}
