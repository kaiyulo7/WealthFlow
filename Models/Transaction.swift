import Foundation

enum TransactionType: String, Codable {
    case buy = "Buy"
    case sell = "Sell"
}

enum Market: String, Codable {
    case tw = "TW"
    case us = "US"
}

struct Transaction: Identifiable, Codable {
    var id: String
    var symbol: String
    var market: Market
    var type: TransactionType
    var price: Double
    var qty: Double
    var fee: Double
    var isMargin: Bool
    var marginRate: Double?
    var interestRate: Double?
    var date: Date
}
