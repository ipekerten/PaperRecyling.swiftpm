//
//  ThirdView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 08/02/25.
//

import SwiftUI

struct ThirdPulping: View {
    @State private var rotationAngle: Double = 0
    @State private var lastAngle: Double = 0
    @State private var rectangleColor: Color = .red
    
    let rotationThreshold = 180.0 // Renk değiştirme eşiği

    private func updateRotation(_ newAngle: Double) {
        let rotations = Int(newAngle / rotationThreshold)

        switch rotations {
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
                Image("wheel")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(rotationAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let center = CGPoint(x: 75, y: 75) // Tekerleğin merkezi
                                let touchPoint = value.location
                                
                                let angle = atan2(touchPoint.y - center.y, touchPoint.x - center.x) * 180 / .pi
                                let deltaAngle = angle - lastAngle
                                
                                if abs(deltaAngle) < 50 { // Ani sıçramaları önlemek için
                                    updateRotation(rotationAngle + deltaAngle)
                                }

                                lastAngle = angle
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
