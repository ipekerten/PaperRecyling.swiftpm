import SwiftUI
import CoreMotion

struct FifthDrying: View {
    @State private var imageName: String = "Press5"
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
            
            Text("Shake your iPad to drain the water and dry the paper!")
                .font(.title2)
                .frame(width: 530, height: 50)
                .background(Color.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: .black, radius: 0, x: 2, y: 2)
                )
                .offset(y: -UIScreen.main.bounds.height / 2 + 100)
            
            if showNextButton {
                NavigationLink() {
                    SixthDrawing()
                } label: {
                    Text("Next")
                        .font(.title)
                }
                .frame(width: 150, height: 70)
                .background(Color.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 2)
                        .shadow(color: .black, radius: 0, x: 2, y: 2)
                )
                .offset(y: -UIScreen.main.bounds.height / 3)
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
