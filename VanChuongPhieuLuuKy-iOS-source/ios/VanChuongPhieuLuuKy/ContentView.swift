import SwiftUI

struct ContentView: View {
    @State private var loadError: String?
    @State private var reloadID = 0

    var body: some View {
        Group {
            if let loadError {
                VStack(spacing: 16) {
                    Image(systemName: "book.closed")
                        .font(.system(size: 42))
                        .foregroundStyle(Color(red: 0.09, green: 0.4, blue: 0.66))
                    Text("Không thể mở ứng dụng")
                        .font(.title3.bold())
                    Text(loadError)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    Button("Thử lại") {
                        self.loadError = nil
                        reloadID += 1
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(28)
            } else {
                LocalWebView(reloadID: reloadID) { message in
                    loadError = message
                }
            }
        }
        .background(Color(red: 0.31, green: 0.72, blue: 0.96))
    }
}
