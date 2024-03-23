//
//  ToolsViewController.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/23/24.
//

import Foundation
import SwiftUI

final class ToolsViewController: ObservableObject {
    static var shared = ToolsViewController()
    @Published var selection: Tools
    @Published public var size: Double
    @Published var color: Color
    
    init() {
        self.selection = .circle
        self.size = 0.3
        self.color = .yellow
    }
    
    public func updateColor(_ color: Color) {
        self.color = color
    }
    
    public func isColorSelected(_ color: Color) -> Bool {
        if self.color == color {
            return true
        }
        return false
    }
    
    public func updateTool(_ tool: Tools) {
        self.selection = tool
    }
    
    public func isToolSelected(_ tool: Tools) -> Bool {
        if self.selection == tool {
            return true
        }
        return false
    }
    
    public func getToolImage(_ tool: Tools) -> String {
        
        if tool == .circle {
            return "plus.circle"
        } else if tool == .square {
            return "plus.square"
        } else if tool == .erase {
            return "eraser"
        } else if tool == .trash {
            return "trash"
        }
        return ""
    }
    
}

enum Tools {
    case circle, square, erase, trash
}

