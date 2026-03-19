import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                List(viewModel.historicalSnapshots) { snapshot in
                    HStack {
                        Text(dateFormatter.string(from: snapshot.date))
                            .foregroundColor(.white)
                        Spacer()
                        Text(snapshot.totalAssetsTWD, format: .currency(code: "TWD"))
                            .foregroundColor(.green)
                            .bold()
                    }
                    .listRowBackground(Color(UIColor.darkGray).opacity(0.2))
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("History")
        }
    }
}
