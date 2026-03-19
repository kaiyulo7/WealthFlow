import Foundation

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    
    private init() {}
    
    func signInWithGoogle() async throws -> Bool {
        // Mock authentication delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return true
    }
    
    func signOut() {
        // Handle explicit sign out
    }
    
    func getCurrentUser() -> String? {
        // Return a mock user id for now
        return "mock_user_123"
    }
}
