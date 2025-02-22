//
//  SixthView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 12/02/25.
//

import SwiftUI
import PencilKit

struct PaperDrawingView: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var body: some View {
        ZStack {
            DrawingCanvasView(canvasView: $canvasView)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding()
            
            VStack {
                Spacer()
                
                NavigationLink {
                    FinishedView()
                } label: {
                    Text("Done")
                        .font(.title)
                .frame(width: 100, height: 50)
                .background(Color.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: .black, radius: 0, x: 2, y: 2)
                )
                }
                .padding(.bottom, 20)
            }
        }
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
    PaperDrawingView()
}
