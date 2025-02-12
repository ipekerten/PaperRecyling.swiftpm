//
//  SecondView.swift
//  PaperRecyling
//
//  Created by Ipek Erten on 07/02/25.
//

import SwiftUI

struct SecondSeparating: View {
    struct DraggableItem: Identifiable {
        let id = UUID()
        var color: Color
        var offset: CGSize = .zero
        var lastOffset: CGSize = .zero
    }

    struct DropZone {
        var originalColor: Color
        var currentColor: Color
        var frame: CGRect = .zero
        
        init(color: Color) {
            self.originalColor = color
            self.currentColor = color
        }
    }

    @State private var draggableItems: [DraggableItem] = [
        DraggableItem(color: .blue), DraggableItem(color: .blue),
        DraggableItem(color: .red), DraggableItem(color: .red),
        DraggableItem(color: .green), DraggableItem(color: .green)
    ]
    
    @State private var dropZones: [DropZone] = [
        DropZone(color: .blue), DropZone(color: .red), DropZone(color: .green)
    ]

    let droppedColors: [Color] = [.pink, .orange, .gray] // New colors after drop

    var body: some View {
        GeometryReader { geometry in
            if draggableItems.isEmpty {
                NavigationLink("Next") {
                    ThirdView()
                }
                .font(.title)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .position(x: geometry.size.width / 2, y: geometry.size.height - 200)
            }

            VStack(spacing: 20) {
                ForEach(0..<dropZones.count, id: \.self) { index in
                    Rectangle()
                        .fill(dropZones[index].currentColor.opacity(0.5))
                        .frame(width: 200, height: 100)
                        .overlay(Text("Drop here").foregroundColor(.white))
                        .background(
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    DispatchQueue.main.async {
                                        dropZones[index].frame = proxy.frame(in: .global)
                                    }
                                }
                            }
                        )
                }
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 3)

            ForEach(draggableItems.indices, id: \.self) { index in
                Circle()
                    .fill(draggableItems[index].color)
                    .frame(width: 50, height: 50)
                    .offset(draggableItems[index].offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                draggableItems[index].offset = CGSize(
                                    width: draggableItems[index].lastOffset.width + value.translation.width,
                                    height: draggableItems[index].lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                let circleFrame = CGRect(
                                    x: (geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 35)) + CGFloat(index * 70) + draggableItems[index].offset.width,
                                    y: (geometry.size.height - 100) + draggableItems[index].offset.height,
                                    width: 50,
                                    height: 50
                                )

                                for i in dropZones.indices {
                                    if dropZones[i].frame.intersects(circleFrame),
                                       dropZones[i].originalColor == draggableItems[index].color {
                                        DispatchQueue.main.async {
                                            if index < draggableItems.count {
                                                draggableItems.remove(at: index)
                                            }
                                            // Change drop zone color after successful drop
                                            dropZones[i].currentColor = droppedColors[i % droppedColors.count]
                                        }
                                       // return
                                    }
                                }
                                draggableItems[index].lastOffset = draggableItems[index].offset
                            }
                    )
                    .position(
                        x: geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 35) + CGFloat(index * 70),
                        y: geometry.size.height - 100
                    )
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .navigationBarHidden(true)
    }
}


#Preview {
    SecondSeparating()
}
