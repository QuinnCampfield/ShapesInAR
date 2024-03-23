//
//  ContentView.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/23/24.
//

import SwiftUI

struct ContentView : View {
    @State private var initial = true
    var body: some View {
        ZStack {
            ARViewDisplay()
            ARToolsDisplay()
            HStack{
                Spacer()
                VStack {
                    Button {
                        initial.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .padding()
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $initial, content: {
            HelpView()
        })
    }
}

#Preview {
    ContentView()
}
