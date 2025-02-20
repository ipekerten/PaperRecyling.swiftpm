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
    @State private var toolPicker = PKToolPicker()
    
    var body: some View {
        ZStack {
            Image("Artboard 1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            DrawingCanvasView(canvasView: $canvasView)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding()
        }
        .navigationTitle("Draw on Recycled Paper")
        .onAppear {
            showToolPicker()
        }
        .navigationBarHidden(true)
    }

    func showToolPicker() {
        DispatchQueue.main.async {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
        }
    }
}


struct DrawingCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = UIColor.clear
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

#Preview {
    SixthDrawing()
}
