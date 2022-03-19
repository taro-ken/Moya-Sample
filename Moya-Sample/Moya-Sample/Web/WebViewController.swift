//
//  Web.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/17.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

  @IBOutlet private weak var webView: WKWebView!

  private var githubModel: GithubModel?

  func configure(githubModel: GithubModel) {
    self.githubModel = githubModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    guard
      let githubModel = githubModel,
      let url = URL(string: githubModel.urlStr) else {
      return
    }
    webView.load(URLRequest(url: url))
  }
}
