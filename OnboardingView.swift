//
//  OnboardingView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 19/02/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        NavigationStack {
                ZStack {
                    Color(red: 247/255, green: 110/255, blue: 69/255)
                        .ignoresSafeArea(edges: .all)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 600, height: 300)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                        .shadow(color: .black, radius: 0, x: 4, y: 4)

                    VStack {
                        Text("Welcome!")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .padding(90)

                        NavigationLink {
                            FirstCollecting()
                        } label: {
                            Text("START")
                                .font(.system(size: 14))
                        }
                        .padding(6)
                        .frame(width: 80, height: 30)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.black, lineWidth: 2)
                                .shadow(color: .black, radius: 0, x: 3, y: 2)
                            
                        )
                        
                    }
                    .navigationBarHidden(true)
                }
        }
    }
}

#Preview {
    OnboardingView()
}



