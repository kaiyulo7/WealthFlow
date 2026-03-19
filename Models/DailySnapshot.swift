import Foundation

struct DailySnapshot: Identifiable, Codable {
    var id: String { date.description }
    var date: Date
    var twValue: Double
    var usValueUSD: Double
    var cash: Double
    var marginDebt: Double
    var taiexPrice: Double
    var fxRate: Double
    
    // Computed aggregate value
    var totalAssetsTWD: Double {
        twValue + (usValueUSD * fxRate) + cash
    }
}
