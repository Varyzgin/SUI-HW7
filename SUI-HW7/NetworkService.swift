//
//  NetworkManager.swift
//  SUI-HW6
//
//  Created by Dim on 01.07.2025.
//

import Foundation

enum RequestType {
    case list
    case fullInfo(String)
    case related([String])
    
    var path: String {
        switch self {
        case .list:
            return "/photos"
        case .fullInfo(let id):
            return "/photos/\(id)"
        case .related(let topics):
            if topics.first != nil {
                return "/search/photos"
            } else {
                return "/photos"
            }
        }
    }
}

struct PhotoShortInfo: Decodable {
    let id: String
    let urls: Urls
    let description: String?
    let alt_description: String?
    let updated_at: String
    
    struct Urls : Decodable {
        let small: String
        let regular: String
        let thumb: String
    }
}

struct PhotoFullInfo : Decodable {
    let tags: [Tag]
    struct Tag : Decodable {
        let title: String
    }
}

struct PhotoRelatedInfo : Decodable {
    let results: [Result]
    struct Result: Decodable {
        let urls: Urls
        struct Urls : Decodable {
            let small: String
            let regular: String
            let thumb: String
        }
    }
}

struct NetworkService {
    let urlString: String
    
    func sendRequest<T : Decodable>(for requestType: RequestType, params: [String: String] = [:], headers: [String: String] = [:], responseType: T.Type, completion: @escaping (T) -> Void) {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.path = requestType.path
        urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        print(request)

        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard error == nil, let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response)
            } catch {
                print("Error decoding JSON: \(error)\nAnd site said: (String(data: data, encoding: .utf8))")
            }
        }.resume()
    }
}
