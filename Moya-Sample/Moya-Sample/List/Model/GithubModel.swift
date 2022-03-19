//
//  GithubModel.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/17.
//

import Foundation

struct GithubResponse: Codable {
 let items: [GithubModel]?
}

struct GithubModel: Codable {
  let fullName: String
  var urlStr: String { "https://github.com/\(fullName)" }

  enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
  }
}


