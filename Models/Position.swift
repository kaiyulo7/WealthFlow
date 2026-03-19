import Foundation

struct Position: Identifiable {
    var id: String { symbol }
    var symbol: String
    var market: Market
    var totalQty: Double
    var avgCost: Double
    var currentPrice: Double
    var totalFees: Double
    var isMargin: Bool
    
    var marketValue: Double {
        currentPrice * totalQty
    }
    
    var unrealizedPnL: Double {
        (currentPrice - avgCost) * totalQty - totalFees
    }
    
    var roiPercentage: Double {
        let costBasis = avgCost * totalQty
        guard costBasis > 0 else { return 0 }
        return (unrealizedPnL / costBasis) * 100
    }
}
