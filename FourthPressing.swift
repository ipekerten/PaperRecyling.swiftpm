//
//  FifthView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 10/02/25.
//


import SwiftUI

struct FourthPressing: View {
    private let colors: [Color] = [.pink, .blue, .cyan, .orange, .yellow]
    
    @State private var index: Int = 0
    @State private var lastTranslation: CGSize = .zero
    @State private var changeCount: Int = 0
    private let maxChanges = 5  // Maksimum 5 değişim
    private let sensitivity: CGFloat = 350 // Renk değiştirmek için gereken hareket mesafesi

    var body: some View {
        ZStack {
            Rectangle()
                .fill(colors[index])
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: index) // Smooth geçiş
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            guard changeCount < maxChanges else { return } // 5 değişimden sonra dur
                            
                            let movement = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2))
                            let lastMovement = sqrt(pow(lastTranslation.width, 2) + pow(lastTranslation.height, 2))
                            let delta = movement - lastMovement
                            
                            if abs(delta) > sensitivity, index < colors.count - 1 { // Hassasiyet mesafesini aştıysa
                                withAnimation {
                                    index += 1
                                    changeCount += 1
                                    lastTranslation = value.translation
                                }
                            }
                        }
                        .simultaneously(with: DragGesture(minimumDistance: 0)) // İki parmak gerektirir
                )
            Text("Move your finger on the screen")
            if index == colors.count - 1 {
                NavigationLink("Next") {
                    FifthDrying()
                }
                .padding()
                .foregroundColor(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FourthPressing()
}







