import SwiftUI
import CoreMotion

struct FifthDrying: View {
    @State private var backgroundColor: Color = .white
    @State private var colorIndex: Int = 0
    @State private var showNextButton: Bool = false
    
    private let motionManager = CMMotionManager()
    private let accelerationThreshold = 2.5
    private let colors: [Color] = [.white, .blue, .cyan, .mint, .pink, .yellow, .purple, .green, .orange, .red]

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    startMonitoringAccelerometer()
                }
            
            if showNextButton {
                NavigationLink("Next") {
                    SixthDrawing()
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

    private func startMonitoringAccelerometer() {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer not available")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data, !self.showNextButton else { return }
            
            let acceleration = data.acceleration
            let magnitude = sqrt(acceleration.x * acceleration.x +
                                 acceleration.y * acceleration.y +
                                 acceleration.z * acceleration.z)
            
            if magnitude > self.accelerationThreshold {
                DispatchQueue.main.async {
                    if self.colorIndex < self.colors.count - 1 {
                        self.colorIndex += 1
                        self.backgroundColor = self.colors[self.colorIndex]
                    }
                    
                    if self.colorIndex == self.colors.count - 1 {
                        self.showNextButton = true
                        self.motionManager.stopAccelerometerUpdates()
                    }
                }
            }
        }
    }
}

#Preview {
    FifthDrying()
}
