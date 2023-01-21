//
//  BaseAPI.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Codable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, ErrorMessages>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method,parameters: params.0, encoding: params.1, headers: headers).validate().response { (response) in
            print(" ------\( target.baseURL + target.path)")
            //print("respone is \(response.value ?? "")")
            switch response.result {
            case .success(_):
                print("Responce ",response.value as Any)
                guard let data = response.data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(M.self, from: data)
                    completion(.success(jsonData))

                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print(error)
                guard let data = response.data else { return }
                guard let statusCode = response.response?.statusCode else { return }
                print("Status code ->",response.response?.statusCode ?? 0)
                switch statusCode {
                case 400..<500:
                    do {
                        _ = try JSONDecoder().decode(M.self, from: data)
                        completion(.failure(.noInternet))

                    } catch let jsonError {
                        print(jsonError)
                        completion(.failure(.noInternet))
                    }
                default:
                    completion(.failure(.noInternet))
                }
            }
      }
    }
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding())
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
