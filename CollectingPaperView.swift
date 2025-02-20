import SwiftUI

struct CollectingPaperView: View {
    struct DraggableItem: Identifiable {
        var id = UUID()
        var offset: CGSize = .zero
        var lastOffset: CGSize = .zero
        var imageName: String
    }

    @State private var draggableItems: [DraggableItem] = [
        DraggableItem(imageName: "Trash1"),
        DraggableItem(imageName: "Trash2"),
        DraggableItem(imageName: "Trash3"),
        DraggableItem(imageName: "Trash4")
    ]

    @State private var rectFrame: CGRect = .zero
    @State private var recycleBinImage: String = "RecycleBin"
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }

    var body: some View {
            ZStack {
                Color(red: 255/255, green: 187/255, blue: 2/255)
                    .ignoresSafeArea()
                
                if !draggableItems.isEmpty {
                    Text("Collect papers into the recycle bin!")
                        .font(.title2)
                        .frame(width: 360, height: 50)
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
                    if draggableItems.isEmpty {
                        NavigationLink() {
                            SecondSeparating()
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
                    
                    Image(recycleBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.7)
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear {
                                let imageWidth: CGFloat = 150
                                let imageHeight: CGFloat = imageWidth * (2.0 / 3.0)
                                
                                rectFrame = CGRect(
                                    x: (geometry.size.width - imageWidth) / 2,
                                    y: (geometry.size.height * 0.7) - (imageHeight / 2),
                                    width: imageWidth,
                                    height: imageHeight
                                )
                            }
                        })
                    
                    
                    ForEach(Array(draggableItems.enumerated()), id: \.element.id) { index, item in
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .offset(item.offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        draggableItems[index].offset = CGSize(
                                            width: draggableItems[index].lastOffset.width + value.translation.width,
                                            height: draggableItems[index].lastOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { value in
                                        draggableItems[index].lastOffset = draggableItems[index].offset
                                        
                                        let imageFrame = CGRect(
                                            x: (geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 70)) + CGFloat(index * 140) + draggableItems[index].lastOffset.width,
                                            y: (geometry.size.height / 3 - 50) + draggableItems[index].lastOffset.height,
                                            width: 140,
                                            height: 140
                                        )
                                        
                                        let isOverlapping = rectFrame.insetBy(dx: -20, dy: -20).intersects(imageFrame)
                                        
                                        if isOverlapping {
                                            draggableItems.remove(at: index)
                                            withAnimation {
                                                recycleBinImage = "RecycleBinFull"
                                            }
                                        }
                                    }
                            )
                            .position(
                                x: geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 75) + CGFloat(index * 150),
                                y: geometry.size.height / 3
                            )
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .navigationBarHidden(true)
            }
    }
}

#Preview {
    CollectingPaperView()
}
