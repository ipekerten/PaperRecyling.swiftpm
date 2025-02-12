//
//  FifthView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 10/02/25.
//

import SwiftUI
import UIKit

struct FourthPressing: View {
    private let colors: [Color] = [.white, .blue, .cyan, .mint, .pink, .yellow, .purple, .green, .orange, .red]
    @State var index: Int = 0
    @State var vertical: Bool = true
    @State private var lastTranslation: CGSize = .zero
    
    var body: some View {
        Rectangle()
            .fill(colors[index])
            .edgesIgnoringSafeArea(.all)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let deltaX = abs(value.translation.width - lastTranslation.width)
                        let deltaY = abs(value.translation.height - lastTranslation.height)
                        
                        if deltaX > 5 || deltaY > 5 { // Sensibilità della gesture
                            index = (index + 1) % colors.count
                            lastTranslation = value.translation
                        }
                    }
                    .onEnded { _ in
                        lastTranslation = .zero
                    }
            )
    }
}
