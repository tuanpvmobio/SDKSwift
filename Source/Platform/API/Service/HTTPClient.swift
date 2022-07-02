//
//  HTTPClient.swift
//  AppDemo
//
//  Created by LinhNobi on 27/09/2021.
//

import Foundation
import UIKit

public class HTTPClient {
        
    static let shared = HTTPClient()
    private var session: URLSession
    
    init() {
        session = URLSession.configured()
    }
    
    func request<T: Codable>(input: ServiceBaseRequest, completion: @escaping (_ value: T?, _ error: BaseError?) -> Void) {
        let params = input.params
        let event = input.event
        
        guard let url = URL(string: input.urlString) else { return }
        let data = try? JSONSerialization.data(withJSONObject: params, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                let failApi = FailAPI(urlString: input.urlString, event: event, params: params)
                print("--------- debug ---------- failApi = ", failApi)
                completion(nil, BaseError.unexpectedError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, BaseError.unexpectedError)
                return
            }
            print("\n\n-------- START REQUEST INPUT")
            print("event = ", event)
            print("param = ")
            DictionaryPrinter.printBeauty(with: params)
            print("------------ END REQUEST INPUT\n")
            print("------------ START Response --------")
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                let dictionaryResponse = ResponseParse.parseJson(from: data)
                DictionaryPrinter.printBeauty(with: dictionaryResponse)
                let result = JSONManager.decode(T.self, from: data!)
                completion(result, nil)
            } else {
                let baseError = BaseError.httpError(httpCode: statusCode)
                print("------------- Base Error ------- ", baseError.errorMessage ?? "no error")
                completion(nil, baseError)
            }
            print("------------ END Response --------")
        }.resume()
    }
}
