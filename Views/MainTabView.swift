import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            // 1. Portfolio
            PortfolioView()
                .tabItem {
                    Image(systemName: "briefcase.fill")
                    Text("Portfolio")
                }
            
            // 2. Dashboard
            DashboardView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Dashboard")
                }
            
            // 3. CashFlow (Placeholder)
            Text("CashFlow View")
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("CashFlow")
                }
            
            // 4. History
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
        }
        .accentColor(.green)
        .preferredColorScheme(.dark)
    }
}
