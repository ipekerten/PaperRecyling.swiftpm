//
//  ThirdView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 08/02/25.
//

import SwiftUI

struct ThirdPulping: View {
    @State private var rotationAngle: Double = 0
    @State private var totalRotation: Double = 0
    @State private var lastAngle: Double = 0

    @State private var pulpingImage: String = "Pulping1"

    let rotationThreshold = 300.0

    private func updateRotation(_ deltaAngle: Double) {
        rotationAngle += deltaAngle
        totalRotation += abs(deltaAngle)

        let rotations = Int(totalRotation / rotationThreshold)

        switch rotations {
        case 2: pulpingImage = "Pulping2"
        case 4: pulpingImage = "Pulping3"
        case 6: pulpingImage = "Pulping4"
        default: break
        }
    }

    var body: some View {
        ZStack {
            Color(red: 114/255, green: 112/255, blue: 245/255)
                .ignoresSafeArea()
            
            if pulpingImage == "Pulping4" {
                NavigationLink() {
                    FourthPressing()
                }label: {
                    Text("Next")
                        .font(.title)
                }
                .frame(width: 150, height: 70)
                .background(Color.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: .black, radius: 0, x: 2, y: 2)
                )
                .offset(y: -UIScreen.main.bounds.height / 3)
            }

            VStack {
               
                Image("Wheel")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .rotationEffect(.degrees(rotationAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let center = CGPoint(x: 75, y: 75)
                                let touchPoint = value.location
                                
                                let angle = atan2(touchPoint.y - center.y, touchPoint.x - center.x) * 180 / .pi
                                let deltaAngle = angle - lastAngle
                                
                                if abs(deltaAngle) < 50 {
                                    updateRotation(deltaAngle)
                                }

                                lastAngle = angle
                            }
                    )
                    .offset(x: UIScreen.main.bounds.width / 3,
                            y: 90)

                Image(pulpingImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9,
                           maxHeight: UIScreen.main.bounds.height * 0.7)
            }
        }
        .navigationBarHidden(true)
    }

}

#Preview {
    ThirdPulping()
}
