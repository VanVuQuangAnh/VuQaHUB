import SwiftUI
import UIKit
import WebKit

struct LocalWebView: UIViewRepresentable {
    let reloadID: Int
    let onError: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onError: onError)
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        context.coordinator.reloadID = reloadID
        context.coordinator.load(in: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard context.coordinator.reloadID != reloadID else { return }
        context.coordinator.reloadID = reloadID
        context.coordinator.load(in: webView)
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private let onError: (String) -> Void
        var reloadID = 0

        init(onError: @escaping (String) -> Void) {
            self.onError = onError
        }

        func load(in webView: WKWebView) {
            guard
                let webDirectory = Bundle.main.resourceURL?.appendingPathComponent("WebApp", isDirectory: true),
                FileManager.default.fileExists(atPath: webDirectory.appendingPathComponent("index.html").path)
            else {
                reportError("Không tìm thấy nội dung web được đóng gói trong ứng dụng.")
                return
            }

            webView.loadFileURL(
                webDirectory.appendingPathComponent("index.html"),
                allowingReadAccessTo: webDirectory
            )
        }

        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard navigationAction.navigationType == .linkActivated,
                  let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            if url.isFileURL {
                decisionHandler(.allow)
            } else if url.scheme?.lowercased() == "https" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.cancel)
            }
        }

        func webView(
            _ webView: WKWebView,
            createWebViewWith configuration: WKWebViewConfiguration,
            for navigationAction: WKNavigationAction,
            windowFeatures: WKWindowFeatures
        ) -> WKWebView? {
            if navigationAction.targetFrame == nil,
               let url = navigationAction.request.url,
               url.scheme?.lowercased() == "https" {
                UIApplication.shared.open(url)
            }
            return nil
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            reportError(error.localizedDescription)
        }

        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            reportError(error.localizedDescription)
        }

        private func reportError(_ message: String) {
            DispatchQueue.main.async {
                self.onError(message)
            }
        }
    }
}
