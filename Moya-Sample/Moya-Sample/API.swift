//
//  API.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/17.
//

import Foundation

enum GithubError: Error {
  case error
}

final class GithubAPI {
  static let shared = GithubAPI()

  private init() {}

  func get(searchWord: String, completion: ((Result<[GithubModel], GithubError>) -> Void)? = nil) {
    guard searchWord.count > 0 else {
      completion?(.failure(.error))
      return
    }
    let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
            let models = githubResponse.items else {
        completion?(.failure(.error))
        return
      }
      completion?(.success(models))
    })
    task.resume()
  }
}
