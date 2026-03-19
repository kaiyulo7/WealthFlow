import Foundation

class MockPriceService {
    static let shared = MockPriceService()
    
    private init() {}
    
    func fetchPrice(for symbol: String) async throws -> Double {
        // Simulate network delay for API call (e.g. yfinance)
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let basePrice = Double(symbol.count) * 10.0
        let randomness = Double.random(in: -5.0...5.0)
        return abs(basePrice + randomness)
    }
    
    // Mock FX Rate
    func fetchFXRateUSDToTWD() async throws -> Double {
        try await Task.sleep(nanoseconds: 200_000_000)
        return 31.5
    }
}
