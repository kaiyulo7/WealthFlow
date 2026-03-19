import Foundation

class FirestoreManager {
    static let shared = FirestoreManager()
    
    private init() {}
    
    // Mock for saving transactions
    func saveTransaction(_ transaction: Transaction) async throws {
        // Simulate network
        try await Task.sleep(nanoseconds: 500_000_000)
    }
    
    // Mock for fetching transactions
    func fetchTransactions(for userId: String) async throws -> [Transaction] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return [] // Return empty in mock
    }
    
    // Mock for saving snapshots
    func saveDailySnapshot(_ snapshot: DailySnapshot) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
    }
}
