//
//  GithubAPI.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/17.
//

import Foundation
import Moya

enum GithubError: Error {
    case error
}

enum GithubAPI {
    case user
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=swift&sort=stars") else {
            fatalError("base URL error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .user:
            return ""
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    func get(completion: ((Result<[GithubModel], GithubError>) -> Void)? = nil) {
        
        let provider = MoyaProvider<GithubAPI>()
        provider.request(.user){ result in
            print(result)
            switch result {
            case.success(let response):
                let data = response.data
                guard  let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
                       let models = githubResponse.items else {
                           return
                       }
                completion?(.success(models))
            case.failure(let error):
                completion?(.failure(GithubError.error))
            }
        }
    }
}
