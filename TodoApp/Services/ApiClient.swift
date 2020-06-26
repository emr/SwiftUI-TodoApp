import Foundation

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
}

struct ApiClient {
    
    @UrlPath var baseUrl: String
    var decoder = JSONDecoder()
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func get<T: Decodable>(path: String, onSuccess: @escaping (T) -> Void) throws -> Void {
        let request = try createRequest(path)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if data == nil || error != nil {
                return
            }
            
            onSuccess(self.decodeResult(data!))
        }.resume()
    }
    
    func post<T: Decodable>(path: String, onSuccess: @escaping (T) -> Void) throws -> Void {
        let request = try createRequest(path, method: "POST")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if data == nil || error != nil {
                return
            }
            
            onSuccess(self.decodeResult(data!))
        }.resume()
    }
    
    private func createRequest(_ path: String, method: String? = nil) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)/\(normalizePath(path))") else {
            throw ApiClientError.cannotCreateUrl(baseUrl: baseUrl, path: path)
        }
        var request = URLRequest(url: url)
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
