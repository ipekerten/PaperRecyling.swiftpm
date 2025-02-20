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
                    .frame(width: 600, height: 400)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                    .shadow(color: .black, radius: 0, x: 4, y: 4)

                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome to RePaper!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Let’s recycle paper together! Collect, separate, and press it into fresh sheets. Use your Apple Pencil and gestures to complete each step—draw, drag, and interact to bring recycling to life!")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)

                    HStack {
                        Spacer()
                        NavigationLink {
                            CollectingPaperView()
                        } label: {
                            Text("START")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding(6)
                        .frame(width: 100, height: 40)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.black, lineWidth: 2)
                                .shadow(color: .black, radius: 0, x: 3, y: 2)
                        )
                    }
                }
                .frame(width: 500)
                .padding(.horizontal, 30)
                .navigationBarHidden(true)
            }
        }
    }
}


#Preview {
    OnboardingView()
}



