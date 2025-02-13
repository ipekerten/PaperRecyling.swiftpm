//
//  ThirdView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 08/02/25.
//

import SwiftUI

struct ThirdPulping: View {
    @State private var rotationAngle: Double = 0
    @State private var rectangleColor: Color = .red
    
    let rotationThreshold = 250.0 // rotation degree
    
    private func updateRotation(_ newAngle: Double) {
        let newRotations = Int(newAngle / rotationThreshold)

        // Change color based on full rotations
        switch newRotations {
        case 2: rectangleColor = .blue
        case 4: rectangleColor = .green
        case 6: rectangleColor = .yellow
        default: break
        }

        rotationAngle = newAngle
    }
    
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
                                let newAngle = rotationAngle + dragAmount / 6
                                updateRotation(newAngle)
                            }
                    )
            }
            .padding()

            // Rectangle that changes color
            Rectangle()
                .fill(rectangleColor)
                .frame(width: 200, height: 100)
                .cornerRadius(10)

            // Show Next button only when the rectangle is yellow
            if rectangleColor == .yellow {
                NavigationLink("Next") {
                    FourthPressing()
                }
                .padding(.top, 20)
                .font(.title)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ThirdPulping()
}
