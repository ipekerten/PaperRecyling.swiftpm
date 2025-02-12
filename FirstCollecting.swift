import SwiftUI

struct FirstCollecting: View {
    struct DraggableItem {
        // Current position offset of the circle.
        var offset: CGSize = .zero
        // Saves the position when the drag ends.
        var lastOffset: CGSize = .zero
    }
    //An array of 4 draggable circles, each with an initial offset of .zero.
    @State private var draggableItems: [DraggableItem] = Array(repeating: DraggableItem(), count: 4)
    //Stores the frame (position and size) of the drop zone rectangle.
    @State private var rectFrame: CGRect = .zero
    @State private var rectColor: Color = .blue
    
    
    var body: some View {
        NavigationStack {
                //GeometryReader is used to get the screen size for positioning elements.
                GeometryReader { geometry in
                    if draggableItems.isEmpty {
                        NavigationLink("Next") {
                            SecondSeparating()
                        }
                        .font(.title)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 200)
                        
                    }
                    
                    Rectangle()
                        .fill(rectColor.opacity(0.5))
                        .frame(width: 200, height: 100)
                        .overlay(Text("Drop here").foregroundColor(.white))
                    //Centers the rectangle on the screen
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    //onAppear: Saves the rectangle’s position and size into rectFrame for later collision detection.
                        .onAppear {
                            rectFrame = CGRect(
                                x: (geometry.size.width - 200) / 2,
                                y: (geometry.size.height - 100) / 2,
                                width: 200,
                                height: 100
                            )
                        }
                    
                    
                    
                    //ForEach iterates over the draggableItems array to create 4 circles.
                    ForEach(0..<draggableItems.count, id: \.self) { index in
                        Circle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                            .offset(draggableItems[index].offset)
                            .gesture(
                                DragGesture()
                                //onChanged: Updates offset based on drag movement.
                                    .onChanged { value in
                                        draggableItems[index].offset = CGSize(
                                            width: draggableItems[index].lastOffset.width + value.translation.width,
                                            height: draggableItems[index].lastOffset.height + value.translation.height
                                        )
                                    }
                                /* onEnded: When the user stops dragging:
                                 Saves the lastOffset for future drags.
                                 Calculates circleFrame, the new position of the circle.
                                 Checks if circleFrame intersects with rectFrame (drop zone).
                                 Prints whether the circle is overlapping the drop zone.
                                 */
                                    .onEnded { value in
                                        draggableItems[index].lastOffset = draggableItems[index].offset
                                        
                                        let circleFrame = CGRect(
                                            x: (geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 35)) + CGFloat(index * 70) + draggableItems[index].lastOffset.width,
                                            y: (geometry.size.height / 3 - 25) + draggableItems[index].lastOffset.height,
                                            width: 50,
                                            height: 50
                                        )
                                        
                                        let isOverlapping = rectFrame.intersects(circleFrame)
                                        print("Circle \(index + 1) Overlapping Rectangle? ->", isOverlapping)
                                        print(rectFrame)
                                        print(circleFrame)
                                        if isOverlapping {
                                            draggableItems.remove(at: index)
                                            rectColor = .yellow
                                        }
                                        
                                    }
                            )
                            .position(
                                x: geometry.size.width / 2 - (CGFloat(draggableItems.count - 1) * 35) + CGFloat(index * 70),
                                y: geometry.size.height / 3
                            )
                        
                    }
                    
                    
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .navigationBarHidden(true)
        }
    }
}
