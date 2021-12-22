//
//  MarvelService.swift
//  MarvelChallenge
//
//  Created by VICTOR MOREIRA MELLO on 22/12/21.
//

import Foundation
import CryptoKit
import Alamofire

protocol MarvelService {
    typealias RequestType = (EventDataWrapperModel) -> Void

    func fetchEvents(limit: Int,
                     offset: Int,
                     completionHandler: @escaping RequestType)
}

class MarvelServiceImp: MarvelService {

    static let LIMIT =  20
    static let OFFSET = 0

    private let baseUrl = "https://gateway.marvel.com/v1/public"
    private let publicKey = "2dd999c3ed11ed12eb9a4fd38444b3a4"
    private let privateKey = "c67104a683dbfa5ef8e17114584ade00fed35f76"

    private let jsonDecoder: JSONDecoder = {
        let bodyDecoder = JSONDecoder()
        bodyDecoder.keyDecodingStrategy = .convertFromSnakeCase
        bodyDecoder.dateDecodingStrategy = .iso8601
        return bodyDecoder
    }()

    private func fetchApi<T>(
        endpoint: String,
        parameters: [String: Any] = [:],
        type: T.Type = T.self,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) where T: Decodable {
        var parameters = parameters
        let timeStamp = String(Date().hashValue)
        let toHash = timeStamp + privateKey + publicKey
        let hash = md5Hash(toHash)

        parameters["ts"] = timeStamp
        parameters["apikey"] = publicKey
        parameters["hash"] = hash

        print( " asdasd")

        AF.request("\(baseUrl)\(endpoint)", parameters: parameters)
            .validate(statusCode: 200..<300)
            .response(completionHandler: { response in
                debugPrint(response)
            })
            .responseDecodable(of: type,
                               decoder: jsonDecoder,
                               completionHandler: completionHandler)
    }

    func fetchEvents(limit: Int = LIMIT, offset: Int = OFFSET, completionHandler: @escaping RequestType ) {
        let params = ["limit": limit, "offset": offset]

        fetchApi(endpoint: "/events",
                 parameters: params,
                 type: EventDataWrapperModel.self) { response in

            if let err = response.error {
                print(" errr")
                print(err)
                return
            }

            guard let data = response.value else {
                print("null")
                return
            }

            completionHandler(data)
        }
    }

    func md5Hash(_ source: String) -> String {
        return Insecure.MD5
            .hash(data: source.data(using: .utf8)!)
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}
