import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    if viewModel.historicalSnapshots.isEmpty {
                        ProgressView()
                    } else {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("30-Day Total Asset Trend")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(gradient: Gradient(colors: [.green.opacity(0.5), .clear]), startPoint: .top, endPoint: .bottom))
                                .frame(height: 200)
                                .overlay(
                                    Text("Chart Visualization Area")
                                        .foregroundColor(.white.opacity(0.5))
                                )
                                .padding(.horizontal)
                            
                            Divider().background(Color.gray).padding(.vertical)
                            
                            Text("User ROI vs TAIEX")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(UIColor.darkGray).opacity(0.3))
                                .frame(height: 150)
                                .overlay(
                                    Text("Comparison Chart Stub")
                                        .foregroundColor(.white.opacity(0.5))
                                )
                                .padding(.horizontal)
                                
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}
