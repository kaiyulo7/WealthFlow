import Foundation
import Combine

@MainActor
class PortfolioViewModel: ObservableObject {
    @Published var twPositions: [Position] = []
    @Published var usPositions: [Position] = []
    
    @Published var cash: Double = 100_000
    @Published var marginDebt: Double = 0
    @Published var fxRateUSDToTWD: Double = 31.5
    
    @Published var totalAssetsTWD: Double = 0
    @Published var totalUnrealizedPnLTWD: Double = 0
    @Published var leverageRatio: Double = 1.0
    
    init() {
        // Load mock positions for preview
        loadMockInitialData()
        calculatePortfolio()
    }
    
    func loadMockInitialData() {
        self.twPositions = [
            Position(symbol: "2330", market: .tw, totalQty: 1000, avgCost: 500, currentPrice: 550, totalFees: 200, isMargin: false),
            Position(symbol: "2603", market: .tw, totalQty: 2000, avgCost: 150, currentPrice: 140, totalFees: 400, isMargin: true)
        ]
        
        self.usPositions = [
            Position(symbol: "AAPL", market: .us, totalQty: 50, avgCost: 150, currentPrice: 175, totalFees: 15, isMargin: false),
            Position(symbol: "TSLA", market: .us, totalQty: 100, avgCost: 200, currentPrice: 195, totalFees: 30, isMargin: true)
        ]
    }
    
    func updateMarketData() async {
        do {
            self.fxRateUSDToTWD = try await MockPriceService.shared.fetchFXRateUSDToTWD()
            calculatePortfolio()
        } catch {
            print("Failed to fetch market data: \(error)")
        }
    }
    
    func calculatePortfolio() {
        let twMarketValue = twPositions.reduce(0) { $0 + $1.marketValue }
        let twPnL = twPositions.reduce(0) { $0 + $1.unrealizedPnL }
        
        let usMarketValueUSD = usPositions.reduce(0) { $0 + $1.marketValue }
        let usPnLUSD = usPositions.reduce(0) { $0 + $1.unrealizedPnL }
        
        let usMarketValueTWD = usMarketValueUSD * fxRateUSDToTWD
        let usPnLTWD = usPnLUSD * fxRateUSDToTWD
        
        self.marginDebt = calculateTotalMarginDebt()
        
        self.totalAssetsTWD = twMarketValue + usMarketValueTWD + cash
        self.totalUnrealizedPnLTWD = twPnL + usPnLTWD
        
        let netEquity = self.totalAssetsTWD - self.marginDebt
        if netEquity > 0 {
            self.leverageRatio = self.totalAssetsTWD / netEquity
        } else {
            self.leverageRatio = 1.0
        }
    }
    
    private func calculateTotalMarginDebt() -> Double {
        var debt: Double = 0
        for position in twPositions where position.isMargin {
            debt += (position.avgCost * position.totalQty) * 0.6
        }
        for position in usPositions where position.isMargin {
            debt += (position.avgCost * position.totalQty) * 0.5 * fxRateUSDToTWD
        }
        return debt
    }
}
