//
//  SecondView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 07/02/25.
//

import SwiftUI

struct SeparatingPaperView: View {
    struct DraggableItem: Identifiable, Equatable {
        let id = UUID()
        var imageName: String
        var offset: CGSize = .zero
        var lastOffset: CGSize = .zero
    }
    
    struct DropZone {
        var originalImage: String
        var currentImage: String
        var frame: CGRect = .zero
        
        init(image: String) {
            self.originalImage = image
            self.currentImage = image
        }
    }
    
    @State private var draggableItems: [DraggableItem] = [
        DraggableItem(imageName: "Trash1"), DraggableItem(imageName: "Trash2"),
        DraggableItem(imageName: "Trash3"), DraggableItem(imageName: "Trash4"),
        DraggableItem(imageName: "Trash5"), DraggableItem(imageName: "Trash6")
    ]
    
    @State private var dropZones: [DropZone] = [
        DropZone(image: "Newspapers"), DropZone(image: "Cardboards"), DropZone(image: "ComputerPapers")
    ]
    
    @State private var droppedItems: Set<UUID> = []
    
    let droppedImages: [String: String] = [
        "Newspapers": "NewspapersFull",
        "Cardboards": "CardboardsFull",
        "ComputerPapers": "ComputerPapersFull"
    ]
    
    let validMatches: [String: String] = [
        "Trash1": "Newspapers", "Trash6": "Newspapers",
        "Trash2": "Cardboards", "Trash5": "Cardboards",
        "Trash3": "ComputerPapers", "Trash4": "ComputerPapers"
    ]
    
    var body: some View {
        ZStack {
            Color(red: 122/255, green: 229/255, blue: 201/255)
                .ignoresSafeArea()
            
            if !draggableItems.allSatisfy({ droppedItems.contains($0.id) }) {
                Text("Separate papers into the categories!")
                    .font(.title2)
                    .frame(width: 380, height: 50)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.black, lineWidth: 2)
                            .shadow(color: .black, radius: 0, x: 2, y: 2)
                    )
                    .offset(y: -UIScreen.main.bounds.height / 2 + 100)
            }
            
            GeometryReader { geometry in
                if draggableItems.allSatisfy({ droppedItems.contains($0.id) }) {
                    NavigationLink() {
                        PulpingPaperView()
                    } label: {
                        Text("Next")
                            .font(.title)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.black, lineWidth: 2)
                            .shadow(color: .black, radius: 0, x: 2, y: 2)
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 3 - 200)
                }
                
                HStack(spacing: 20) {
                    ForEach(dropZones.indices, id: \.self) { index in
                        Image(dropZones[index].currentImage)
                            .resizable()
                            .frame(width: 240, height: 240)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.onAppear {
                                        DispatchQueue.main.async {
                                            dropZones[index].frame = proxy.frame(in: .global)
                                        }
                                    }
                                }
                            )
                            .animation(.easeIn(duration: 0.3), value: dropZones[index].currentImage)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 1.5)
                
                ForEach(draggableItems.indices, id: \.self) { index in
                    let item = draggableItems[index]
                    
                    if !droppedItems.contains(item.id) {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 115, height: 115)
                            .offset(item.offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        draggableItems[index].offset = CGSize(
                                            width: item.lastOffset.width + value.translation.width,
                                            height: item.lastOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { _ in
                                        let itemFrame = CGRect(
                                            x: (geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 60)) + CGFloat(index * 120) + item.offset.width,
                                            y: (geometry.size.height / 3 - 100) + item.offset.height,
                                            width: 50,
                                            height: 50
                                        )
                                        
                                        var isDroppedCorrectly = false
                                        
                                        for i in dropZones.indices {
                                            if dropZones[i].frame.intersects(itemFrame),
                                               validMatches[item.imageName] == dropZones[i].originalImage {
                                                DispatchQueue.main.async {
                                                    droppedItems.insert(item.id)
                                                    dropZones[i].currentImage = droppedImages[dropZones[i].originalImage] ?? dropZones[i].originalImage
                                                    isDroppedCorrectly = true
                                                }
                                            }
                                        }
                                        
                                        if isDroppedCorrectly {
                                            draggableItems[index].lastOffset = draggableItems[index].offset
                                        } else {
                                            withAnimation {
                                                draggableItems[index].offset = .zero
                                            }
                                        }
                                    }
                            )
                            .position(
                                x: geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 60) + CGFloat(index * 120),
                                y: geometry.size.height / 3 - 100
                            )
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SeparatingPaperView()
}
