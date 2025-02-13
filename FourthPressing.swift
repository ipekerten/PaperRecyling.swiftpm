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
    @State private var lastTranslation: CGFloat = 0
    @State private var changeCount: Int = 0
    private let maxChanges = 5  // Maksimum 5 değişim
    private let sensitivity: CGFloat = 220 // Renk değiştirmek için gereken hareket mesafesi

    var body: some View {
        ZStack {
            Rectangle()
                .fill(colors[index])
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            guard changeCount < maxChanges else { return } // 5 değişimden sonra dur

                            let movement = value.translation.width + value.translation.height
                            let delta = movement - lastTranslation
                            
                            if abs(delta) > sensitivity { // Hassasiyet mesafesini aştıysa
                                if index < colors.count - 1 { // Son renkten sonra ilerleme yok
                                    index += 1
                                    lastTranslation = movement
                                    changeCount += 1
                                }
                            }
                        }
                )

            // Yalnızca son renk (yellow) ekranda olduğunda buton görünür olacak
            if index == colors.count - 1 {
                NavigationLink("Next") {
                    FifthDrying()
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
            }
        }
        .navigationBarHidden(true)
    }
}







