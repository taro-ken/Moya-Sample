//
//  Router.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/17.
//

import UIKit

final class Router {
  static let shared = Router()
  private init() {}

  private var window: UIWindow?

  func showRoot(window: UIWindow) {
   
    guard let vc = UIStoryboard.init(name: "List", bundle: nil).instantiateInitialViewController() else {
      return
    }
    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
    self.window = window
  }

  func showWeb(from: UIViewController, githubModel: GithubModel) {
    guard let web = UIStoryboard.init(name: "Web", bundle: nil).instantiateInitialViewController() as? WebViewController else {
      return
    }
    web.configure(githubModel: githubModel)
    show(from: from, to: web)
  }

  private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil){
    if let nav = from.navigationController {
      nav.pushViewController(to, animated: true)
      completion?()
    } else {
      from.present(to, animated: true, completion: completion)
    }
  }
}
