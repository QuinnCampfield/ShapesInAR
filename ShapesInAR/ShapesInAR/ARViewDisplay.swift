//
//  ARViewDisplay.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/22/24.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewDisplay: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ARViewDisplay()
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        ARViewController.shared.startARSession()
        
        return ARViewController.shared.arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}
