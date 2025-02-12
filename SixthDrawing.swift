//
//  SixthView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 12/02/25.
//

import SwiftUI
import PencilKit

struct SixthDrawing: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker() // Use an instance of PKToolPicker
    
    var body: some View {
        ZStack {
            //  Recycled Paper Background
            Image("recycled_paper_texture")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            //  Drawing Canvas
            DrawingCanvasView(canvasView: $canvasView)
                .background(Color.clear) // Keep transparency
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding()
        }
        .navigationTitle("Draw on Recycled Paper")
        .onAppear {
            showToolPicker()
        }
    }
    
    //  Show the PencilKit Tool Picker (Fixed for iOS 14+)
    func showToolPicker() {
        DispatchQueue.main.async {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        }
    }
}

//  PencilKit Canvas Wrapper
struct DrawingCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput // Allows fingers + Apple Pencil
        canvasView.backgroundColor = UIColor.clear // Keep the paper texture visible
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

#Preview {
    SixthDrawing()
}
