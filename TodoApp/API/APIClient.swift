import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

protocol APIClient {
    func send<T: APIRequest>(request: T, completion: @escaping ResultCallback<T.Response>)
}
