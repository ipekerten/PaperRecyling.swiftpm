import SwiftUI
import CoreMotion

struct FifthDrying: View {
    @State private var imageName: String = "Press5" // Başlangıç resmi
    @State private var imageIndex: Int = 0
    @State private var showNextButton: Bool = false

    private let motionManager = CMMotionManager()
    private let accelerationThreshold = 2.5
    private let imageNames = ["Press5", "Dry2", "Dry3", "Dry4", "Dry5", "Dry6", "Dry7", "Dry8", "Dry9", "Dry10"]

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 1.1 * UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    startMonitoringAccelerometer()
                }

            Text("Shake the iPad")
                .foregroundStyle(.black)
            
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
                    if self.imageIndex < self.imageNames.count - 1 {
                        self.imageIndex += 1
                        self.imageName = self.imageNames[self.imageIndex]
                    }
                    
                    if self.imageIndex == self.imageNames.count - 1 {
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
