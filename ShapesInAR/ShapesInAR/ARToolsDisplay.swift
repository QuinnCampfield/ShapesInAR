//
//  ARToolsDisplay.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/22/24.
//

import SwiftUI

struct ARToolsDisplay: View {
    @ObservedObject var toolsVC = ToolsViewController.shared
    var slide: Double = 0.3
    var body: some View {
        VStack {
            HStack {
                // Left Side Tools
                VStack {
                    Spacer()
                    VStack {
                        ToolsButtonView(tool: .circle)
                        Divider()
                            .frame(width: 20)
                        ToolsButtonView(tool: .square)
                        Divider()
                            .frame(width: 20)
                        ToolsButtonView(tool: .erase)
                        Divider()
                            .frame(width: 20)
                        ToolsButtonView(tool: .trash)
                    }
                    .background(Color(red: 36.0/255, green: 36.0/255, blue: 36.0/255))
                }
                Spacer()
                // Right Side Colors
                VStack {
                    Spacer()
                    VStack {
                        ColorButtonView(color: .yellow)
                        Divider()
                            .frame(width: 20)
                        ColorButtonView(color: .red)
                        Divider()
                            .frame(width: 20)
                        ColorButtonView(color: .green)
                    }
                    .background(Color(red: 36.0/255, green: 36.0/255, blue: 36.0/255))
                }
            }
            // Bottom Slider
            VStack {
                Text("\(toolsVC.size, specifier: "%.1f") size")
                Slider(value: $toolsVC.size, in: 0.1...3)
                    .padding(.horizontal)
            }
        }
    }
}

struct ColorButtonView: View {
    @ObservedObject var toolsVC = ToolsViewController.shared
    var color: Color
    var body: some View {
        Button {
            toolsVC.updateColor(color)
        } label: {
            Image(systemName: "circle.fill")
                .padding()
        }
        .foregroundColor(color)
        .background(toolsVC.isColorSelected(color) ? .blue : .clear)
    }
}

struct ToolsButtonView: View {
    @ObservedObject var toolsVC = ToolsViewController.shared
    var tool: Tools
    var body: some View {
        Button {
            toolsVC.updateTool(tool)
        } label: {
            Image(systemName: toolsVC.getToolImage(tool))
                .padding()
        }
        .foregroundColor(toolsVC.isToolSelected(tool) ? .white : .blue)
        .background(toolsVC.isToolSelected(tool) ? .blue : .clear)
    }
}

#Preview {
    ARToolsDisplay()
}
