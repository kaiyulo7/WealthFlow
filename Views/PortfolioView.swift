import SwiftUI

struct PortfolioView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var selectedMarket: Market = .tw
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 24) {
                    DashboardSummaryCard(viewModel: viewModel)
                    
                    Picker("Market", selection: $selectedMarket) {
                        Text("TW Market").tag(Market.tw)
                        Text("US Market").tag(Market.us)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            let positions = selectedMarket == .tw ? viewModel.twPositions : viewModel.usPositions
                            
                            if positions.isEmpty {
                                Text("No active positions.")
                                    .foregroundColor(.secondary)
                                    .padding(.top, 40)
                            } else {
                                ForEach(positions) { position in
                                    PositionRowView(position: position)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("WealthFlow")
            .onAppear {
                Task {
                    await viewModel.updateMarketData()
                }
            }
            // Logout action just for testing the auth flow closure
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Normally this would be handled differently
                        FirebaseAuthManager.shared.signOut()
                    }) {
                        Image(systemName: "person.crop.circle.badge.xmark")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct DashboardSummaryCard: View {
    @ObservedObject var viewModel: PortfolioViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Total Assets (TWD)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(viewModel.totalAssetsTWD, format: .currency(code: "TWD"))
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: viewModel.totalUnrealizedPnLTWD >= 0 ? "arrow.up.right" : "arrow.down.right")
                    Text(viewModel.totalUnrealizedPnLTWD, format: .currency(code: "TWD"))
                }
                .font(.subheadline.bold())
                .foregroundColor(viewModel.totalUnrealizedPnLTWD >= 0 ? .green : .red)
                
                if viewModel.marginDebt > 0 {
                    Text("Leverage: \(viewModel.leverageRatio, specifier: "%.2f")x")
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.15))
                        .foregroundColor(.orange)
                        .cornerRadius(6)
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.darkGray).opacity(0.3))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

struct PositionRowView: View {
    let position: Position
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(position.symbol)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    if position.isMargin {
                        Text("M")
                            .font(.system(size: 9, weight: .black))
                            .padding(4)
                            .background(Color.orange.opacity(0.2))
                            .foregroundColor(.orange)
                            .clipShape(Circle())
                    }
                }
                Text("\(position.totalQty, specifier: "%.0f") shares @ \(position.avgCost, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
             
            VStack(alignment: .trailing, spacing: 6) {
                Text(position.marketValue, format: .currency(code: position.market == .tw ? "TWD" : "USD"))
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(position.unrealizedPnL >= 0 ? "+" : "")\(position.unrealizedPnL, specifier: "%.2f")")
                    .font(.subheadline.bold())
                    .foregroundColor(position.unrealizedPnL >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color(UIColor.darkGray).opacity(0.25))
        .cornerRadius(16)
    }
}
