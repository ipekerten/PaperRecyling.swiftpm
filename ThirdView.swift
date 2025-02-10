//
//  ThirdView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 08/02/25.
//

import SwiftUI

struct ThirdView: View {
    @State private var rotationAngle: Double = 0
    @State private var rotationCount: Int = 0
    @State private var rectangleColor: Color = .red // Default color
    
    let rotationThreshold = 720.0 // two full rotation

    var body: some View {
        VStack {
            // Wheel
            ZStack {
                Circle()
                    .stroke(lineWidth: 5)
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(rotationAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let dragAmount = value.translation.width
                                let newAngle = rotationAngle + dragAmount / 3
                                updateRotation(newAngle)
                            }
                    )
                Text("\(rotationCount)")
                    .font(.largeTitle)
                    .bold()
            }
            
            Spacer().frame(height: 50)

            // Rectangle that changes color
            Rectangle()
                .fill(rectangleColor)
                .frame(width: 200, height: 100)
                .cornerRadius(10)

        }
        .padding()
    }

    private func updateRotation(_ newAngle: Double) {
        let previousRotations = Int(rotationAngle / rotationThreshold)
        let newRotations = Int(newAngle / rotationThreshold)

        // Check if a new full rotation has been completed
        if newRotations > previousRotations {
            rotationCount += 1
            updateRectangleColor()
        }
        
        rotationAngle = newAngle
    }

    private func updateRectangleColor() {
        switch rotationCount {
        case 2: rectangleColor = .blue
        case 4: rectangleColor = .green
        case 6: rectangleColor = .yellow
        default: break
        }
    }
}

#Preview {
    ThirdView()
}
