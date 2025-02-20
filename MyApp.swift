import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .preferredColorScheme(.light)
        }
    }
}
