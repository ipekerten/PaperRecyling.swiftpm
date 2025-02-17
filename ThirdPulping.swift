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

    @State private var pulpingImage: String = "Pulping1" // Başlangıç görseli

    let rotationThreshold = 300.0 // Görsel değiştirme eşiği

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
            // Arka Plan Rengi
            Color(red: 114/255, green: 112/255, blue: 245/255)
                .ignoresSafeArea()
            
            if pulpingImage == "Pulping4" {
                NavigationLink("Next") {
                    FourthPressing()
                }
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .offset(y: -UIScreen.main.bounds.height / 3)
            }

            VStack {
                // Wheel (Döndürülebilir Çark) - Move it to the left
                Image("wheel")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(rotationAngle))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let center = CGPoint(x: 75, y: 75)
                                let touchPoint = value.location
                                
                                let angle = atan2(touchPoint.y - center.y, touchPoint.x - center.x) * 180 / .pi
                                let deltaAngle = angle - lastAngle
                                
                                if abs(deltaAngle) < 50 { // Ani sıçramaları önlemek için
                                    updateRotation(deltaAngle)
                                }

                                lastAngle = angle
                            }
                    )
                    .offset(x: -UIScreen.main.bounds.width / 3.5,
                            y: 90) // Move the wheel to the left by a third of the screen width

                // Değişen Görsel
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
