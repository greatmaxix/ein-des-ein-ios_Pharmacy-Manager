//
//  DataManager.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import Moya
import Result

struct KyivPostError: Error, Equatable, Codable {

    enum CodingKeys: String, CodingKey {
        case error = "message"
        case code = "code"
    }

    let error: String?
    let code: String?
}

protocol ParseKeyPath {
    static var parseKeyPathExtension: String { get }
}

fileprivate struct EnvironmentTarget<T: NetworkTarget>: TargetType {
    let target: T
    let environment: Environment
    
    var method: Moya.Method { target.method }
    var sampleData: Data { target.sampleData }
    var task: Task { target.task }
    var path: String { target.path }
    var baseURL: URL { URL(fileURLWithPath: environment.baseURLPath) }
    var headers: [String : String]? { target.headers }
}

final class DataManager<T, U> where T: NetworkTarget, U: Decodable {

    private let provider = MoyaProvider<EnvironmentTarget<T>>(plugins: DataManager.plugins)
    private let environment = Environment()
    
    public var deleteCompletion: ((Result<Bool, MoyaError>) -> Void)?
    public var updateCompletion: ((Result<Bool, MoyaError>) -> Void)?
    public var createCompletion: ((Result<Bool, MoyaError>) -> Void)?

    public internal(set) var isLoading: Bool = false

    // MARK: - Class vars
    class var plugins: [Moya.PluginType] {
        var result = [PluginType]()

        let accessPlugin = AccessTokenPlugin { _ in
            return KeychainManager.shared.bearerToken
        }
        result.append(accessPlugin)

        return result
    }

    // MARK: - Data Load
    public func load(target: T, completion: @escaping (_ result: Result<U, MoyaError>) -> Void) {
        isLoading = true
        provider.request(EnvironmentTarget(target: target, environment: environment)) { [weak self] (result) in
            self?.requestCompletion(with: result, completion: completion)
        }
    }
    
    public func loadLike<D: Decodable>( _ : D.Type, target: T, completion: @escaping (_ result: Result<D, MoyaError>) -> Void) {
        isLoading = true
        provider.request(EnvironmentTarget(target: target, environment: environment)){ [weak self] (result) in
            self?.requestCompletion(with: result, completion: completion)
        }
    }

    public func requestCompletion<D: Decodable>(with result: Swift.Result<Moya.Response, Moya.MoyaError>,
                                                completion: @escaping (_ result: Result<D, MoyaError>) -> Void) {
        switch result {
        case let .success(response):
            do {
                let successResponse = try response.filterSuccessfulStatusCodes()
                let jsonDecoder = JSONDecoder()
                let keyPath: String

                if let parse = D.self as? ParseKeyPath.Type {
                    keyPath = parse.parseKeyPathExtension
                } else {
                    keyPath = String()
                }

                let data = try successResponse.map(D.self,
                                                   atKeyPath: keyPath,
                                                   using: jsonDecoder,
                                                   failsOnEmptyData: false)
                isLoading = false
                completion(.success(data))
            } catch let error as MoyaError {
                if let parsedError = try? response.map(KyivPostError.self) {
                    completion(.failure(.objectMapping(parsedError, response)))
                } else {
                    completion(.failure(error))
                }
            } catch {
                isLoading = false
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        case let .failure(error):
            isLoading = false
            completion(.failure(error))
        }
    }
    // MARK: - delete request
    public func delete(target: T, completion: @escaping (_ result: Result<Bool, MoyaError>) -> Void) {
        isLoading = true
        self.deleteCompletion = completion
        provider.request(EnvironmentTarget(target: target, environment: environment), completion: deleteCompletion)
    }
    public func deleteCompletion(with result: Swift.Result<Moya.Response, MoyaError>) {
        switch result {
        case let .success(response):
            do {
                let successResponse = try response.filterSuccessfulStatusCodes()

                isLoading = false
                self.deleteCompletion?(.success(successResponse.statusCode == 200))
            } catch let error as MoyaError {
                isLoading = false
                self.deleteCompletion?(.failure(error))
            } catch {
                isLoading = false
                self.deleteCompletion?(.failure(MoyaError.underlying(error, nil)))
            }
        case let .failure(error):
            isLoading = false
            self.deleteCompletion?(.failure(error))
        }
    }
    // MARK: - update request
    public func update(target: T, completion: @escaping (_ result: Result<Bool, MoyaError>) -> Void) {
        isLoading = true
        self.updateCompletion = completion
        provider.request(EnvironmentTarget(target: target, environment: environment), completion: updateCompletion)
    }

    public func updateCompletion(with result: Swift.Result<Moya.Response, MoyaError>) {
        switch result {
        case let .success(response):
            do {
                let successResponse = try response.filterSuccessfulStatusCodes()

                isLoading = false
                self.updateCompletion?(.success(successResponse.statusCode == 200))
            } catch let error as MoyaError {
                isLoading = false
                self.updateCompletion?(.failure(error))
            } catch {
                isLoading = false
                self.updateCompletion?(.failure(MoyaError.underlying(error, nil)))
            }
        case let .failure(error):
            isLoading = false
            self.updateCompletion?(.failure(error))
        }
    }

    public func create(target: T, completion: @escaping (_ result: Result<Bool, MoyaError>) -> Void) {
        isLoading = true
        self.createCompletion = completion
        provider.request(EnvironmentTarget(target: target, environment: environment), completion: createCompletion)
    }
    
    public func createCompletion(with result: Swift.Result<Moya.Response, MoyaError>) {
        switch result {
        case let .success(response):
            do {
                let successResponse = try response.filterSuccessfulStatusCodes()

                isLoading = false
                self.createCompletion?(.success(successResponse.statusCode == 200))
            } catch let error as MoyaError {
                isLoading = false
                self.createCompletion?(.failure(error))
            } catch {
                isLoading = false
                self.createCompletion?(.failure(MoyaError.underlying(error, nil)))
            }
        case let .failure(error):
            isLoading = false
            self.createCompletion?(.failure(error))
        }
    }
}
