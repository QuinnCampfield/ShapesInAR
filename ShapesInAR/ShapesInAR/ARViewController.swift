//
//  ARViewController.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/22/24.
//

import Foundation
import ARKit
import RealityKit


final class ARViewController: ObservableObject {
    static var shared = ARViewController()
    
    @Published var arView: ARView
    private var modelAnchor: AnchorEntity?
    
    private var ToolsVC = ToolsViewController.shared
    
    init() {
        self.arView = ARView(frame: .zero)
    }
    
    public func startARSession() {
        startPlaneDetection()
        
        startTapDetection()
    }
    
    private func startPlaneDetection() {
        arView.automaticallyConfigureSession = true
//        arView.debugOptions = [.showWorldOrigin]
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        config.frameSemantics.insert(.personSegmentationWithDepth)
        
        arView.session.run(config)
    }
    
    private func startTapDetection() {
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        arView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:))))
    }
    
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
            
            if ToolsVC.selection == .circle {
                let mesh = MeshResource.generateSphere(radius: Float(ToolsVC.size) / 10)
                let material = SimpleMaterial(color: UIColor(ToolsVC.color), isMetallic: true)
                let model = ModelEntity(mesh: mesh, materials: [material])
                placeObject(object: model, at: worldPosition)
            } else if ToolsVC.selection == .square {
                let mesh = MeshResource.generateBox(size: Float(ToolsVC.size) / 10)
                let material = SimpleMaterial(color: UIColor(ToolsVC.color), isMetallic: true)
                let model = ModelEntity(mesh: mesh, materials: [material])
                placeObject(object: model, at: worldPosition)
            } else if ToolsVC.selection == .erase {
                for anchor in arView.scene.anchors {
                    if let anchorEntitiy = anchor as? AnchorEntity {
                        let distance = distance(anchorEntitiy.position(relativeTo: nil), worldPosition)
                        if (distance < 0.05) {
                            removeObject(anchor: anchorEntitiy)
                            break
                        }
                    }
                }
            } else if ToolsVC.selection == .trash {
                arView.scene.anchors.removeAll()
            }
        }
    }
    
    @objc
    private func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended {
            let tapLocation = recognizer.location(in: arView)
            
            let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
            
            if let firstResult = results.first {
                let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
                
                
                for anchor in arView.scene.anchors {
                    
                    if let anchorEntitiy = anchor as? AnchorEntity {
                        let distance = distance(anchorEntitiy.position(relativeTo: nil), worldPosition)
                        if (distance < 0.05) {
                            removeObject(anchor: anchorEntitiy)
                        }
                    }
                }
            }
            
            
            
        }
    }
    
    private func placeObject(object modelEntity: ModelEntity, at position: SIMD3<Float>) {
        modelAnchor = AnchorEntity(world: position)
        modelAnchor!.addChild(modelEntity)
        arView.scene.addAnchor(modelAnchor!)
        
    }
    
    private func removeObject(anchor: AnchorEntity) {
        arView.scene.removeAnchor(anchor)
    }
}
