//
//  FifthView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 10/02/25.
//


import SwiftUI

struct FourthPressing: View {
    private let backgroundImages: [String] = ["Press1", "Press2", "Press3", "Press4", "Press5"]
    
    @State private var index: Int = 0
    @State private var lastTranslation: CGSize = .zero
    @State private var changeCount: Int = 0
    private let maxChanges = 5
    private let sensitivity: CGFloat = 350

    var body: some View {
        ZStack {
            Image(backgroundImages[index])
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 1.1 * UIScreen.main.bounds.height)
                .animation(nil, value: index)

            VStack {
                Text("Move your finger on the screen")
                    .foregroundColor(.black)
                
                if index == backgroundImages.count - 1 {
                    NavigationLink() {
                        FifthDrying()
                    } label: {
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
            }
            .padding()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    guard changeCount < maxChanges else { return }
                        
                    let movement = hypot(value.translation.width, value.translation.height)
                    let lastMovement = hypot(lastTranslation.width, lastTranslation.height)
                    let delta = movement - lastMovement
                        
                    if abs(delta) > sensitivity, index < backgroundImages.count - 1 {
                        withAnimation(.linear(duration: 0.2)) { 
                            index += 1
                            changeCount += 1
                            lastTranslation = value.translation
                        }
                    }
                }
        )
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FourthPressing()
}







