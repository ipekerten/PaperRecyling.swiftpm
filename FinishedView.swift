//
//  FinishedView.swift
//  RePaper
//
//  Created by Ipek Erten on 21/02/25.
//

import SwiftUI

struct FinishedView: View {
    var body: some View {
        
        ZStack {
            Color(red: 247/255, green: 110/255, blue: 69/255)
                .ignoresSafeArea(edges: .all)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 600, height: 320)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                .shadow(color: .black, radius: 0, x: 4, y: 4)

            VStack(alignment: .leading, spacing: 20) {
                Text("Great job!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("Recycling is awesome, but using less paper and reusing what we have makes an even bigger impact. \nKeep it up!")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)

                HStack {
                    Spacer()
                    NavigationLink {
                        CollectingPaperView()
                    } label: {
                        Text("RECYLE")
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

#Preview {
    FinishedView()
}
