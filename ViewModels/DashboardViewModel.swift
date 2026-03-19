import Foundation
import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var historicalSnapshots: [DailySnapshot] = []
    
    init() {
        generateMockSnapshots()
    }
    
    func generateMockSnapshots() {
        var snapshots: [DailySnapshot] = []
        let calendar = Calendar.current
        let today = Date()
        
        for i in (0..<30).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let mockTwValue = Double.random(in: 400000...450000)
                let mockUsValue = Double.random(in: 10000...15000)
                
                let snapshot = DailySnapshot(
                    date: date,
                    twValue: mockTwValue,
                    usValueUSD: mockUsValue,
                    cash: 50000,
                    marginDebt: Double.random(in: 10000...50000),
                    taiexPrice: Double.random(in: 17000...18000),
                    fxRate: 31.5
                )
                snapshots.append(snapshot)
            }
        }
        self.historicalSnapshots = snapshots
    }
}
