import Foundation
import Combine

fileprivate func normalizePath(_ path: String) -> String {
    path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
}

@propertyWrapper
struct UrlPath {
    private var path: String
    init() {
        self.path = ""
    }
    var wrappedValue: String {
        get {
            return path
        }
        set {
            path = normalizePath(newValue)
        }
    }
}

enum ApiClientError: Error {
    case cannotCreateUrl(baseUrl: String, path: String)
    case responseError
}

struct ApiClient {
    
    @UrlPath var baseUrl: String
    var decoder = JSONDecoder()
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func get<T: Decodable>(path: String) throws -> AnyPublisher<T, Error> {
        let request = try createRequest(path)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200 == httpResponse.statusCode else {
                    throw ApiClientError.responseError
                }
                return self.decodeResult(data)
            }
            .eraseToAnyPublisher()
    }
    
    func post<T: Decodable>(path: String) throws -> AnyPublisher<T, Error> {
        let request = try createRequest(path, method: "POST")
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 201 == httpResponse.statusCode else {
                    throw ApiClientError.responseError
                }
                return self.decodeResult(data)
        }
        .eraseToAnyPublisher()
    }
    
    private func createRequest(_ path: String, method: String? = nil) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)/\(normalizePath(path))") else {
            throw ApiClientError.cannotCreateUrl(baseUrl: baseUrl, path: path)
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        if method != nil {
            request.httpMethod = method
        }
        return request
    }
    
    private func decodeResult<T: Decodable>(_ data: Data) -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse api result as \(T.self):\n\(error)")
        }
    }
    
}
