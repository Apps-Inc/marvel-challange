//
//  MarvelService.swift
//  MarvelChallenge
//
//  Created by VICTOR MOREIRA MELLO on 22/12/21.
//

import Foundation
import CryptoKit
import Alamofire

enum ServiceReturn {
    case success(Service.EventsType)
    case noContent
    case error(Error)
}

protocol Service {
// MARK: - EventsRequest
    typealias EventsType = EventDataWrapperModel
    typealias EventsHandler = (ServiceReturn) -> Void

    func fetchEvents(page: Int, completionHandler: @escaping EventsHandler)
}

private enum DateDecodingError: Error {
    case noValue
    case unstringable
    case unknownDateFormat(String)
}

class MarvelService: Service {

    private let limit = 20
    private let baseUrl = "https://gateway.marvel.com/v1/public"
    private let publicKey = "2dd999c3ed11ed12eb9a4fd38444b3a4"
    private let privateKey = "c67104a683dbfa5ef8e17114584ade00fed35f76"

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            guard let container = try? decoder.singleValueContainer() else {
                throw DateDecodingError.noValue
            }

            guard let dateString = try? container.decode(String.self) else {
                throw DateDecodingError.unstringable
            }

            let formatter = DateFormatter()

            // Você acha que a API retorna datas em formato consistente? Eu
            // também achava.
            for dateFormat in [
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd HH:mm:ss"
            ] {
                formatter.dateFormat = dateFormat

                if let date = formatter.date(from: dateString) {
                    return date
                }
            }

            throw DateDecodingError.unknownDateFormat(dateString)
        }

        return decoder
    }()

    // MARK: - public func
    func fetchEvents(
        page: Int = 1,
        completionHandler: @escaping EventsHandler
    ) {
        let params = ["limit": limit, "offset": (page - 1) * limit]

        fetchApi(
            endpoint: "/events",
            parameters: params,
            type: EventsType.self
        ) { response in
            if let error = response.error {
                completionHandler(.error(error))
                return
            }

            guard let data = response.value else {
                completionHandler(.noContent)
                return
            }

            completionHandler(.success(data))
        }
    }

// MARK: - private func
    private func fetchApi<T>(
        endpoint: String,
        parameters: [String: Any] = [:],
        type: T.Type = T.self,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) where T: Decodable {
        var parameters = parameters
        let timeStamp = String(Date().hashValue)
        let toHash = timeStamp + privateKey + publicKey

        parameters["ts"] = timeStamp
        parameters["apikey"] = publicKey
        parameters["hash"] = md5Hash(toHash)

        AF.request("\(baseUrl)\(endpoint)", parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: type,
                               decoder: jsonDecoder,
                               completionHandler: completionHandler)
    }

    private func md5Hash(_ source: String) -> String {
        return Insecure.MD5
            .hash(data: source.data(using: .utf8)!)
            .map { String(format: "%02hhx", $0) }
            .joined()
    }
}
