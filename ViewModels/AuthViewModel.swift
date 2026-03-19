import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loginWithGoogle() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let success = try await FirebaseAuthManager.shared.signInWithGoogle()
                self.isAuthenticated = success
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func logout() {
        FirebaseAuthManager.shared.signOut()
        self.isAuthenticated = false
    }
}
